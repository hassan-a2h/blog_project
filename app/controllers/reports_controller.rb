# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :confirm_sign_in
  before_action :confirm_user, only: [:destroy]

  def new
    if params[:post_id]
      @post = find_post
      @report = @post.reports.new
      redirect_to root_path, alert: 'Report can not be generated!' unless @report
    elsif params[:comment_id]
      @comment = find_comment
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
      @comment = find_comment
      @report = @comment.reports.new(whitelist_params)

      if @report.save
        redirect_to root_path, notice: 'Your report has been submitted!'
      else
        redirect_to root_path, alert: 'Error! your report could not be submitted.'
      end
    end
  end

  def destroy
    report = find_report
    redirect_to root_path, notice: 'Report dismissed' if report.destroy
  end

  private

  def whitelist_params
    params.require(:report).permit(:message, :user_id)
  end

  def confirm_sign_in
    redirect_to root_path, alert: 'Action Forbidden!' unless user_signed_in?
  end

  def confirm_user
    redirect_to root_path, alert: 'Error! Prohibited Action.' unless current_user.mod? || current_user.admin?
  end

  def find_post
    post = params[:id] ? Post.find_by(id: params[:id]) : Post.find_by(id: params[:post_id])
    redirect_to root_path, alert: 'Error! could not find post' unless post
    post
  end

  def find_comment
    comment = params[:id] ? Comment.find_by(id: params[:id]) : Comment.find_by(id: params[:comment_id])
    redirect_to root_path, alert: 'Error! could not find comment' unless comment
    comment
  end

  def find_report
    report = params[:id] ? Report.find_by(id: params[:id]) : Report.find_by(id: params[:report_id])
    redirect_to root_path, alert: 'Error! could not find report' unless report
    report
  end
end
