class MessagesController < ApplicationController
  # before_action :message, except: %i!edit update destroy!
  before_action :message, except: :create
  before_action :conversation

  def create
    @conversation.messages.create(new_message_params.merge({user_id: current_user.id}))
    redirect_to conversation_path(@conversation)
  end

  def edit
  end

  def update
    @message.update(message_params)
    redirect_to @conversation
  end

  def destroy
    @message.remove
    @message.image.purge
    @message.save
    redirect_to @conversation
  end

  def remove_asset
    @message.image.purge
    redirect_to edit_conversation_message_path @message
  end

  private

  def message_params
    params.require(:message).permit(:content, :conversation_id, :image)
  end

  def new_message_params
    params.permit(:content, :conversation_id, :image)
  end

  def message
    @message = Message.find(params[:id])
  end

  def conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end
