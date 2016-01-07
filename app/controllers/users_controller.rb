class UsersController < ApplicationController
  def index
  end

  def show
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in @user
      flash[:success] = t "sign_up_success"
      redirect_back_or root_url
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  private
  def user_params
    params.required(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
