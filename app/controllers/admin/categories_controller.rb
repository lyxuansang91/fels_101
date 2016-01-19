class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin
  before_action :load_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "t.category.create_success"
      redirect_to [:admin, :categories]
    else
      render :new
    end
  end

  def update
    if @category.update category_params
      flash[:success] = t "category.update_success"
      redirect_to [:admin, :categories]
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    if @category.destroy
      flash[:success] = t "category.delete_success"
      redirect_to [:admin, :categories]
    else
      flash[:danger] = t "category.delete_error"
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end

  def load_category
    @category = Category.find params[:id]
  end
end
