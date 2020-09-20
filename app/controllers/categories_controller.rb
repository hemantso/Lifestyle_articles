class CategoriesController < ApplicationController
  before_action :require_admin, except: %i[index show]
  def index
    @categories = Category.all
    @article = Article.all.order(created_at: :desc).includes(:user)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save

      flash[:success] = 'Category was created successfully'

      redirect_to categories_path

    else
      flash[:danger] = 'Category was not created'
      render 'new'

    end
  end

  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.order(created_at: :desc).includes(:user)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(category_params)

      flash[:success] = 'Category name was successfully updated'

      redirect_to category_path(@category)

    else
      flash[:danger] = 'Category was not updated'
      render 'edit'

    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      return flash[:danger] = 'Only admins can perform that action'
    end

    redirect_to categories_path
  end
end
