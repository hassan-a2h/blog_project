# frozen_string_literal: true

class HomepagesController < ApplicationController
  before_action :authorized, only: [:reports]

  def index
    if user_signed_in?
      if current_user.admin?
        redirect_to admin_homepage_path
      elsif current_user.mod?
        redirect_to mod_homepage_path
      elsif current_user.user?
        redirect_to user_homepage_path
      end
    end

    @posts = Post.all.order(created_at: :desc)
  end

  def user
    #### Polymorhphic associations are not getting eagerloaded.
    @posts = Post.all.order(created_at: :desc).includes(:likes, :comments, :suggestions)
  end

  def mod
    @all_posts = Post.where(status: :published).order(created_at: :desc)
    @all_comments = Comment.all.order(created_at: :desc)
  end

  def admin
    @posts = Post.where(status: :published)
    @comments = Comment.all
  end

  def my_posts
    @posts = Post.published_by(current_user.id)
  end

  def my_comments
    @comments = Comment.by_user(current_user.id).includes(:post)
  end

  def my_likes
    @likes = Like.made_by(current_user.id)
  end

  def reports
    @reported_posts = Report.where(reportable_type: 'Post', status: :pending)
    @reported_comments = Report.where(reportable_type: 'Comment', status: :pending)
  end

  private

  def authorized
    redirect_to root_path 'Prohibited Action!' unless current_user.mod?
  end
end
