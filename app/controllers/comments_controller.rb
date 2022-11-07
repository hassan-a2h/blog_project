class CommentsController < ApplicationController
  # Filters
  # Only signed in users can post
  before_action :confirm_sign_in

  # Actions
  def index
    @post = Post.find_by(id: params[:post_id])

    unless @post
      redirect_to root_path, alert: "Prohibited Action!"
    end

    @comments = Comment.by_post(@post)
    # To allow user to comment while viewing all comments
    @comment = Comment.new(user_id: current_user.id, post_id: @post.id)
  end

  def new

  end

  def create
    @post = Post.find_by(params[:post_id])
    @comment = @post.comments.new(whitelist_params)

    if @comment.save
      redirect_to post_comments_path(@post), notice: "Comment Added!"

    else
      redirect_to root_path, alert: "Error! could not add comment"

    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  # To whitelist params
  def whitelist_params
    params.require(:comment).permit(:user_id, :body)
  end

  # To confirm user
  def confirm_sign_in
    unless user_signed_in?
      redirect_to root_path, alert: "Action Forbidden!"
    end
  end
end
