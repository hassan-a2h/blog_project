# frozen_string_literal: true

class RepliesController < ApplicationController
  before_action :confirm_sign_in
  before_action :confirm_user, only: :destroy

  def index
    @parent = params[:comment_id] ? find_comment : find_suggestion
    @replies = @parent.replies.includes(:user).all
    @new_reply = @parent.replies.new
  end

  def create
    @parent = params[:comment_id] ? find_comment : find_suggestion
    @reply = @parent.replies.new(whitelist_params)

    if @reply.save
      redirect_to root_path, notice: 'Reply made'
    else
      redirect_to root_path, alert: 'Error! could not save reply'
    end
  end

  def destroy
    reply = find_reply
    redirect_to root_path, notice: 'Reply removed!' if reply.destroy
  end

  private

  def whitelist_params
    params.require(:reply).permit(:body, :user_id)
  end

  def confirm_sign_in
    redirect_to root_path, alert: 'Action Forbidden!' unless user_signed_in?
  end

  def confirm_user
    return if find_reply.user_id == current_user.id || current_user.mod?

    redirect_to root_path, alert: 'Error! Prohibited Action.'
  end

  def find_comment
    comment = params[:id] ? Comment.find_by(id: params[:id]) : Comment.find_by(id: params[:comment_id])
    redirect_to root_path, alert: 'Error! could not find comment' unless comment
    comment
  end

  def find_suggestion
    suggestion = params[:id] ? Suggestion.find_by(id: params[:id]) : Suggestion.find_by(id: params[:suggestion_id])
    redirect_to root_path, alert: 'Error! could not find suggestion' unless suggestion
    suggestion
  end

  def find_reply
    reply = params[:id] ? Reply.find_by(id: params[:id]) : Reply.find_by(id: params[:reply_id])
    redirect_to root_path, alert: 'Error! could not find reply' unless reply
    reply
  end
end
