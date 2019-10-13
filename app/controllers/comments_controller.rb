class CommentsController < ApplicationController

  # before_action :comment_params
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]


  def create
    @comment = Comment.new(comment_params)
    @comment.commentable_type = "Article"
    @comment.user = current_user
    @comment.commentable = Article.find(comment_params[:article_id])
    ap @comment
    render root_path
  end

  def index
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
