class HomepagesController < ApplicationController

  def index

    if user_signed_in?
      if current_user.role_admin?
        redirect_to admin_homepage_path

      elsif current_user.role_mod?
        redirect_to mod_homepage_path

      elsif current_user.role_user?
        redirect_to user_homepage_path

      end

    end

    @posts = Post.all

  end

  def user
    if session[:post_comments]
      @post = Post.find_by(id: session[:post_comments])
      session.delete(:post_comments) # To clear session so that we don't get stuck in loop.
      redirect_to post_comments_path(@post)
    end

    #### Polymorhphic associations are not getting eagerloaded.
    @posts = Post.where(status: :published).includes(:likes, :comments, :suggestions)
    @comments = Comment.by_user(current_user.id).includes(:post)
  end

  def mod
    if session[:post_comments]
      @post = Post.find_by(id: session[:post_comments])
      redirect_to post_comments_path(@post)
    end

    @all_posts = Post.where(status: :published)
    @all_comments = Comment.all
    @reported_posts = Report.where(reportable_type: 'Post')
    @reported_comments = Report.where(reportable_type: 'Comment')
  end

  def dismiss_report
    @report = Report.find_by(id: params[:report_id])
    redirect_to root_path, alert: 'Error! Could not find Report' unless @report

    if @report.status_resolved!
      redirect_to root_path, notice: 'Report has been marked resolved!'

    else
      redirect_to root_path, notice: 'Could not resolve report'

    end
  end

  def admin
    if session[:post_comments]
      @post = Post.find_by(id: session[:post_comments])
      redirect_to post_comments_path(@post)
    end

    @posts = Post.where(status: :published)
    @comments = Comment.all
  end

end
