class UsersController < ApplicationController

  before_action :admin_user, only: [:index, :change_role]
  before_action :show_user, only: [:show]

  NUMBER_OF_REVIEWS_ON_PAGE = 10

  def show_user
    if !user_signed_in?
      redirect_to reviews_path, notice: t('alerts.user.not_auth_user')
    else
      @user = User.find_by(id: params[:id])
      if (@user!=current_user && !current_user.admin)
        redirect_to reviews_path, notice: t('alerts.user.not_auth_user')
      end
    end
  end

  def admin_user
    if !user_signed_in?
      redirect_to reviews_path, notice: t('alerts.user.not_auth_user')
    else
      if !current_user.admin
        redirect_to reviews_path, notice: t('alerts.user.not_auth_user')
      end
    end
  end
  
  def index
    @users = User.all.paginate(page: params[:page], per_page: NUMBER_OF_REVIEWS_ON_PAGE)
  end

  def show
    @user = User.find_by_id(params[:id])
    @reviews = Review.all.paginate(page: params[:page], per_page: NUMBER_OF_REVIEWS_ON_PAGE)
  end

  def change_role
    @user = User.find_by_id(params[:id])
    if params[:admin].present? && params[:admin]!=true && params[:admin]!=false
      @user.update(admin: params[:admin])
      redirect_to @user, notice: t('alerts.user.role_changed')
    else
      redirect_to @user, alert: t('alerts.user.invalid_role')
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: t('alerts.user.successfully_updated')
    else
      redirect_to @user, notice: t('alerts.user.wasnt_updated')
    end
  end
end
