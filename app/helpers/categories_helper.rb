module CategoriesHelper
  def get_pull index
    index % 2 == 0 ? "pull-left" : "pull-right"
  end
end
