class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @activities = @current_user.recent_activity.paginate page: params[:page], per_page: Settings.per_page
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
