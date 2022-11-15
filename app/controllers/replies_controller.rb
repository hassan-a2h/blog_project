class RepliesController < ApplicationController
  def index
    params[:comment_id] ? @parent = Comment.find_by(id: params[:comment_id]) : @parent = Suggestion.find_by(id: params[:suggestion_id])
    @replies = @parent.replies.includes(:user).all
    @new_reply = @parent.replies.new
  end

  def create
    params[:comment_id] ? @parent = Comment.find_by(id: params[:comment_id]) : @parent = Suggestion.find_by(id: params[:suggestion_id])
    @reply = @parent.replies.new(whitelist_params)

    if @reply.save
      redirect_to root_path, notice: 'Variable initialzed'

    else
      redirect_to root_path, alert: 'Error! could not save reply'
    end

  end

  def destroy
    # Find report
    reply = Reply.find_by(id: params[:id])
    redirect_to root_path, alert: 'Error! Could not find reply.' unless reply

    redirect_to root_path, notice: 'Reply removed!' if reply.destroy
  end

  private

  def whitelist_params
    params.require(:reply).permit(:body, :user_id)
  end
end
