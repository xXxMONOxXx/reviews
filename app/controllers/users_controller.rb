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
      redirect_to @user, notice: "Role changed."
    else
      redirect_to @user, alert: "Invalid parameter for role."
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice:"User was successfully updated."
    else
      redirect_to @user, notice:"User wasn't updated."
    end
  end
end
