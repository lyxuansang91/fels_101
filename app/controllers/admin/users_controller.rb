class Admin::UsersController < ApplicationController
  before_action :authenticate_admin
  before_action :find_user, only: [:update, :destroy]

  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "user.update_success"
      respond_to do |format|
        format.html {redirect_to [:admin, @user]}
        format.js
      end
    else
      flash[:danger] = t "user.update_error"
      redirect_to :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user.destroy_success"
      respond_to do |format|
        format.html {redirect_to [:admin, :users]}
        format.js
      end
    else
      flash[:danger] = t "user.destroy_error"
      redirect_to [:admin, :users]
    end
  end

  private
  def find_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :admin
  end
end
