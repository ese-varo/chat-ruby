class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.all
  end
  
  def new
    @conversation = Conversation.new
  end

  def create
    @conversation = Conversation.new(conversation_params)
    if @conversation.save
      redirect_to conversations_path
    else
      render :new
    end
  end

  private
  def conversation_params
    params.require(:conversation).permit(:status)
  end
end
