class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]

  NUMBER_OF_REVIEWS_ON_PAGE = 10

  def search
    if params[:search].present?
      @results = Review.order(created_at: :desc).global_search(params[:search])
    else
      @results = Review.order(created_at: :desc)
    end
  end

  def tagged
    if params[:tag].present?
      @reviews = Review.tagged_with(params[:tag]).paginate(page: params[:page], per_page: NUMBER_OF_REVIEWS_ON_PAGE)
    else
      @reviews = Review.all.paginate(page: params[:page], per_page: NUMBER_OF_REVIEWS_ON_PAGE)
    end
  end

  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all.paginate(page: params[:page], per_page: NUMBER_OF_REVIEWS_ON_PAGE)
  end

  # GET /reviews/1 or /reviews/1.json
  def show
    @favorite_exists = Favorite.where(review: @review, user: current_user) == [] ? false : true
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: t('alerts.review.successfully_created')}
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: t('alerts.review.successfully_updated')}
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    
    users = User.all
    users.each do |user|
      favorite = Favorite.where(review: @review, user: user)
      if favorite != []
        favorite.destroy_all
      end
    end

    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice:t('alerts.review.successfully_destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:title, :body, :user_id, :content, :rating, :tag_list)
    end
end
