class LikesController < ApplicationController
  ## Filters
  # Only signed in users can post
  before_action :confirm_sign_in

  # Only the owner can edit the post
  before_action :confirm_user, only: [:edit, :destroy]

  ## Controller Actions
  def new
    @post = Post.find_by(id: params[:post_id])

    redirect_to root_path, alert: "Error! couldn't find post." unless @post

    @like = @post.likes.new(user_id: current_user.id)
    @old_like = Like.find_by(user_id: current_user.id, likeable_type: 'Post', likeable_id: @post.id)

    if @old_like
      redirect_to root_path, alert: 'Unliked!' if @old_like.destroy
      return
    end

    if @like.save
      redirect_to root_path, notice: 'Post Liked!'

    else
      redirect_to root_path, alert: "Error! couldn't post like."
    end
  end

  private

  def confirm_sign_in
    unless user_signed_in?
      redirect_to root_path, alert: 'Action Forbidden!'
    end
  end

  def confirm_user
    suggestion = Suggestion.find_by(id: params[:id])
    unless suggestion.user_id == current_user.id || suggestion.post.user_id == current_user.id
      redirect_to root_path, alert: 'Error! Prohibited Action.'
    end
  end
end
