class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.all
  end

  def new
  end

  def show
    @user_names = user_names
    @conversation = Conversation.find(params[:id])
  end

  def create
    @conversation = current_user.conversations.build

    if @conversation.save
      byebug
      @conversation.users << User.all.find(conversation_params)

      redirect_to conversation_path(@conversation)
    else
      render :new
    end
  end

  private
  def user_names
    Hash[User.all.collect { |user| [user.id, user.username] }]
  end

  def conversation_params
    params.permit(:eluser_id)
  end

  def participant_params(conversation)
    { conversation_id: conversation.id, user_id: current_user.id }
  end
end
