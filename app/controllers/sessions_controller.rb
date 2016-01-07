class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = t "login_success"
      redirect_to root_url
    else
      flash[:danger] = t "wrong_email_password"
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
