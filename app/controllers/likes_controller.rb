# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :confirm_sign_in

  def new
    if params[:post_id]
      @post = find_post
      @like = @post.likes.new(user_id: current_user.id)
      @old_like = Like.find_by(user_id: current_user.id, likeable_type: 'Post', likeable_id: @post.id)

      if @old_like
        redirect_to root_path, alert: 'Post Unliked!' if @old_like.destroy
      elsif @like.save
        redirect_to root_path, notice: 'Post Liked!'
      else
        redirect_to root_path, alert: "Error! couldn't like."
      end

    else
      @comment = find_comment
      @like = @comment.likes.new(user_id: current_user.id)
      @old_like = Like.find_by(user_id: current_user.id, likeable_type: 'Comment', likeable_id: @comment.id)
      post = Post.find_by(id: @comment.post_id)
      redirect_to root_path, alert: 'Post not Found!' unless post

      if @old_like
        redirect_to post_comments_path(post), alert: 'Comment Unliked!' if @old_like.destroy
      elsif @like.save
        redirect_to post_comments_path(post), notice: 'Comment Liked!'
      else
        redirect_to root_path, alert: "Error! couldn't like."
      end
    end
  end

  private

  def confirm_sign_in
    redirect_to root_path, alert: 'Action Forbidden!' unless user_signed_in?
  end

  def find_post
    post = params[:id] ? Post.find_by(id: params[:id]) : Post.find_by(id: params[:post_id])
    redirect_to root_path, alert: 'Error! could not find post' unless post
    post
  end

  def find_comment
    comment = params[:id] ? Comment.find_by(id: params[:id]) : Comment.find_by(id: params[:post_id])
    redirect_to root_path, alert: 'Error! could not find comment' unless comment
    comment
  end
end
