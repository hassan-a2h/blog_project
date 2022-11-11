class ReportsController < ApplicationController\
  ## Controller Filters
  # Only signed in users can post
  before_action :confirm_sign_in

  # Only the owner can edit the post
  before_action :confirm_user, only: [:destroy]

  # Only admin and mod can view reports

  def new
    if params[:post_id]
      @post = Post.find_by(id: params[:post_id])
      redirect_to root_path, alert: 'Post not found!' unless @post

      @report = @post.reports.new
      redirect_to root_path, alert: 'Report can not be generated!' unless @report

    elsif params[:comment_id]
      @comment = Comment.find_by(id: params[:comment_id])
      redirect_to root_path, alert: 'Post not found!' unless @comment

      @report = @comment.reports.new
      redirect_to root_path, alert: 'Report can not be generated!' unless @report

    end
  end

  def create
    if params[:post_id]
      @report = Report.new(whitelist_params)
      @report[:reportable_type] = 'Post'
      @report[:reportable_id] = params[:post_id]

      if @report.save
        redirect_to root_path, notice: 'Your report has been submitted!'

      else
        redirect_to root_path, alert: 'Error! your report could not be submitted.'

      end

    elsif params[:comment_id]
      @comment = Comment.find_by(id: params[:comment_id])
      redirect_to root_path, alert: 'Could not find comment!' unless @comment
      @report = @comment.reports.new(whitelist_params)

      if @report.save
        redirect_to root_path, notice: 'Your report has been submitted!'

      else
        redirect_to root_path, alert: 'Error! your report could not be submitted.'

      end
    end
  end

  def destroy
    # Find report
    report = Report.find_by(id: params[:id])
    redirect_to root_path, alert: 'Error! Could not find report.' unless report

    redirect_to root_path, notice: 'Report dismissed' if report.destroy
  end

  private

  def whitelist_params
    params.require(:report).permit(:message, :user_id)
  end

  def confirm_sign_in
    unless user_signed_in?
      redirect_to root_path, alert: 'Action Forbidden!'
    end
  end

  def confirm_user
    unless current_user.role_mod? || current_user.role_admin?
      redirect_to root_path, alert: 'Error! Prohibited Action.'
    end
  end

end
