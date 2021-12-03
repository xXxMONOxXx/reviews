class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    @reviews = Review.all
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
