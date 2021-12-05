class FavoritesController < ApplicationController

  NUMBER_OF_REVIEWS_ON_PAGE = 10

  def index
    @favorites = Favorite.where(user: current_user).paginate(page: params[:page], per_page: NUMBER_OF_REVIEWS_ON_PAGE)
  end

  def update
    favorite = Favorite.where(review: Review.find(params[:review]), user: current_user)
    if favorite == []
      Favorite.create(review: Review.find(params[:review]), user: current_user)
      @favorite_exists = true
    else
      favorite.destroy_all
      @favorite_exists = false
    end
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end
end
