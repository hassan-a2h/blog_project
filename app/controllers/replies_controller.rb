class RepliesController < ApplicationController
  def index
    params[:comment_id] ? @parent = Comment.find_by(id: params[:comment_id]) : @parent = Suggestion.find_by(id: params[:suggestion_id])
    @replies = @parent.replies.all
    @new_reply = @parent.replies.new
  end

  def show
  end

  def new
  end

  def create
    params[:comment_id] ? @parent = Comment.find_by(id: params[:comment_id]) : @parent = Suggestion.find_by(id: params[:suggestion_id])
    @reply = @parent.replies.new(whitelist_params)

    if @reply.save
      redirect_to root_path, notice: 'Variable initialzed'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def whitelist_params
    params.require(:reply).permit(:body, :user_id)
  end
end
