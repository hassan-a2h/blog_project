class LikesController < ApplicationController
  ## Filters
  # Only signed in users can post
  before_action :confirm_sign_in

  ## Controller Actions
  def new

    ## Two conditional branches because we have two different likeable entities.
    # One for Post
    if params[:post_id]
      @post = Post.find_by(id: params[:post_id])

      redirect_to root_path, alert: "Error! couldn't find post." unless @post

      @like = @post.likes.new(user_id: current_user.id)

      # Here old comment is used to unlike if already liked.
      @old_like = Like.find_by(user_id: current_user.id, likeable_type: 'Post', likeable_id: @post.id)

      if @old_like
        redirect_to root_path, alert: 'Post Unliked!' if @old_like.destroy

      elsif @like.save
        redirect_to root_path, notice: 'Post Liked!'

      else
        redirect_to root_path, alert: "Error! couldn't like."
      end

    # The other for Comment
    else
      @comment = Comment.find_by(id: params[:comment_id])
      redirect_to root_path, alert: "Error! couldn't find comment." unless @comment

      @like = @comment.likes.new(user_id: current_user.id)

      # Here old comment is used to unlike if already liked.
      @old_like = Like.find_by(user_id: current_user.id, likeable_type: 'Comment', likeable_id: @comment.id)

      # temp_post used to redirect to exact comment section again instead of root_path.
      temp_post = Post.find_by(id: @comment.post_id)

      # Either Unlike, Like or through alert.
      if @old_like
        redirect_to root_path, alert: 'Post not Found!' unless temp_post
        redirect_to post_comments_path(temp_post), alert: 'Comment Unliked!' if @old_like.destroy

      elsif @like.save
        redirect_to root_path, alert: 'Post not Found!' unless temp_post
        redirect_to post_comments_path(temp_post), notice: 'Comment Liked!'

      else
        redirect_to root_path, alert: "Error! couldn't like."
      end
    end
  end

  private

  def confirm_sign_in
    redirect_to root_path, alert: 'Action Forbidden!' unless user_signed_in?
  end
end
