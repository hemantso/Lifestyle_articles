class VotesController < ApplicationController
  before_action :find_article
  before_action :find_like, only: [:destroy]
  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      flash[:success] = 'You successfully voted for an Article'
      @article.votes.create(user_id: current_user.id)
    end
    redirect_to articles_path
  end

  def destroy
    if !already_liked?
      flash[:notice] = 'Cannot unlike the article'
    else
      flash[:danger] = 'Successfully unvoted the article'
      @vote.destroy
    end
    redirect_to articles_path
  end

  private

  def find_article
    @article = Article.find(params[:article_id])
  end

  def already_liked?
    Vote.where(user_id: current_user.id, article_id:
    params[:article_id]).exists?
  end

  def find_like
    @vote = @article.votes.find(params[:id])
  end
end
