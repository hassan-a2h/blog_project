class UsersController < ApplicationController
  before_action :confirm_sign_in
  before_action :confirm_user, only: [:reports]

  def comments
    @comments = Comment.by_user(params[:id])
  end

  def posts
    @posts = Post.published_by(params[:id]).published_posts
  end

  def likes; end

  def reports
    @post_reports = Report.post_reports('Post')
    @comment_reports = Report.comment_reports('Comment')
  end

  def suggestions
    @suggestions = Suggestion.by_user(params[:id]).includes(:post)
  end

  private

  def confirm_sign_in
    redirect_to root_path, alert: 'Action Forbidden!' unless user_signed_in?
  end

  def confirm_user
    return if current_user.admin? || current_user.mod?

    redirect_to root_path, alert: 'Error! Prohibited Action.'
  end
end
