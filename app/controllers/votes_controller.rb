class VotesController < ApplicationController
  before_action :find_article
  before_action :find_like, only: [:destroy]
  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @article.votes.create(user_id: current_user.id)
    end
    redirect_to article_path(@article)
  end

  def destroy
    if !already_liked?
      flash[:notice] = 'Cannot unlike'
    else
      @vote.destroy
    end
    redirect_to article_path(@article)
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
