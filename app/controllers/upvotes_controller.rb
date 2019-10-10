class UpvotesController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    # @si deja upvote, on le supprime (@action = "remove")
    if @article.upvoted?(current_user)
      @upvote = Upvote.where(user: current_user, article: @article).last
      @upvote.delete
    # sinon on upvote (@action = add)
    else
      @upvote = Upvote.create(user: current_user, article: @article)
    end
    respond_to do |format|
      format.html { redirect_to themes_path }
      format.js
    end
  end

end
