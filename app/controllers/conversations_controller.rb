class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.all
  end

  def new
    @users = User.all
  end

  def show
    @user_names = user_names
    @conversation = Conversation.find(params[:id])
  end

  def create
    receiver = User.find(params[:receiver_id])
    @conversation = current_user.conversations.create
    @conversation.users << receiver
    byebug
    redirect_to conversation_path(@conversation)
  end

  private
  def user_names
    Hash[User.all.collect { |user| [user.id, user.username] }]
  end

  def conversation_params
    params.require(:conversation).permit(:receiver_id)
  end
end
