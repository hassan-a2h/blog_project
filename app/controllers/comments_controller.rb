# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :confirm_sign_in
  before_action :confirm_user, only: %i[edit destroy]

  def index
    @post = find_post
    redirect_to root_path, alert: 'Prohibited Action!' unless @post

    @comments = Comment.by_post(@post).includes(:user, :likes)
    @comment = Comment.new
  end

  def new; end

  def create
    @post = find_post
    @comment = @post.comments.new(whitelist_params)

    if @comment.save
      redirect_to post_comments_path(@post), notice: 'Comment Added!'
    else
      redirect_to root_path, alert: 'Error! could not add comment'
    end
  end

  def edit
    @comment = find_comment
    redirect_to root_path, alert: 'Error! could not find comment.' unless @comment
  end

  def update
    @comment = find_comment
    @comment.attachment.purge if whitelist_edit_params

    if @comment.update(whitelist_params)
      redirect_to root_path, notice: 'Comment Updated'
    else
      redirect_to root_path, alert: 'Could not update Comment'
    end
  end

  def destroy
    @comment = find_comment
    redirect_to root_path, alert: 'Error! could not find comment.' unless @comment

    if @comment.destroy
      redirect_to root_path, notice: 'Comment Deleted'
    else
      redirect_to root_path, alert: 'Could not delete Comment'
    end
  end

  private

  def whitelist_params
    params.require(:comment).permit(:user_id, :body, :attachment)
  end

  def whitelist_edit_params
    params.require(:comment).permit(:no_attachment)
  end

  def confirm_sign_in
    redirect_to root_path, alert: 'Action Forbidden!' unless user_signed_in?
  end

  def confirm_user
    return if find_comment.user_id == current_user.id || current_user.mod?

    redirect_to root_path, alert: 'Error! Prohibited Action.'
  end

  def find_comment
    comment = params[:id] ? Comment.find_by(id: params[:id]) : Comment.find_by(id: params[:post_id])
    redirect_to root_path, alert: 'Error! could not find comment' unless comment
    comment
  end

  def find_post
    post = params[:id] ? Post.find_by(id: params[:id]) : Post.find_by(id: params[:post_id])
    redirect_to root_path, alert: 'Error! could not find post' unless post
    post
  end
end
