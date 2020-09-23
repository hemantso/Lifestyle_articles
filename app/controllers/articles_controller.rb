class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy require_same_user]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, only: %i[edit update destroy]
  def index
    @article = Article.all
  end

  def show; end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = 'Article was successfully created'
      redirect_to @article
    else
      flash[:danger] = 'Article was not created'
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      flash[:danger] = 'Article was not updated'
      render :edit
    end
  end

  def destroy
    if @article.destroy
      flash[:danger] = 'Article was successfully deleted'
      redirect_to articles_path
    else
      flash[:danger] = 'Article was not deleted'
      redirect_to root_path
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text, :image, :user_id, category_ids: [])
  end
end
