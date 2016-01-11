class CategoriesController < ApplicationController

  before_action :signed_in_user, only: [:index]

  def index
    @categories = Category.all.paginate page: params[:page], per_page: Settings.per_page
  end
end
