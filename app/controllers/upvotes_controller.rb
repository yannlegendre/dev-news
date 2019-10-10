class UpvotesController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    # si deja upvote, on le supprime
    if article.upvoted?(current_user)
      upvote = Upvote.where(user: current_user, article: article).last
      upvote.delete
    # sinon on upvote
    else
      upvote = Upvote.new(user: current_user, article: article)
      if upvote.save!
        ap "YASS"
      else
        ap 'NOPE'
      end
    end
    redirect_to themes_path
  end

end
