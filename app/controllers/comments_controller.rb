class CommentsController < ApplicationController
  # before_action :comment_params
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]

  def create
    puts params.inspect
    ap params[:content] # retourne nil
    ap params[:article_id] # retourne nil
    article = Article.find(params[:article_id])
    @comment = Comment.new(content: params[:content])
    # @comment.commentable_type = "Article" # utile ?
    @comment.user = current_user
    @comment.commentable = article
    if @comment.save
      # render root_path
      render json: { nb_com: article.comments.count }
    else
      render "themes#index"
    end
  end

  def index
  end
end
