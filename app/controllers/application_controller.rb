class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def signed_in_user
    unless signed_in?
      redirect_to root_url
      flash[:danger] = t "please_sign_in"
    end
  end

  def correct_user
    unless current_user? @user
      flash[:danger] = t "permission_denied"
      redirect_back_or root_url
    end
  end

  def authenticate_admin
    unless current_user.admin?
      flash[:danger] = t "permission_denied"
      redirect_to root_url
    end
  end
end
