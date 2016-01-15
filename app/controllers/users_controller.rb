class UsersController < ApplicationController
  before_action :signed_in_user, except: [:create, :new]
  before_action :find_user, only: [:edit, :update, :show]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "update_user_success"
      redirect_to user_path @user
    end
  end

  def show
    @activities = @user.activities.paginate page: params[:page], per_page: Settings.per_page
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
      :password_confirmation, :avatar
  end

  def find_user
    @user = User.find params[:id]
  end
end
