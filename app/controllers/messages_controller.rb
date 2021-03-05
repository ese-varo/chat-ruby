class MessagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :show_errors
  before_action :require_login, :set_conversation
  before_action :set_message, except: :create
  after_action  :find_emojis, only: [:create, :update]
  # after_action  :trigger_notifications, only: :create

  def create
    @message = @conversation.messages.create(message_params)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  end

  def update
    @message.update(message_params)
    @message.image.purge if params[:message][:remove_asset] == '1'
    redirect_to @conversation
  end

  def destroy
    if MessageDestroyer.call(@message).success?
      flash[:success] = 'Message was succesfully deleted'
    else
      flash[:success] = 'There was a problem deleting the message'
    end
    redirect_to @conversation
  end

  private

  def show_errors
    flash[:error] = "Invalid message!"
    redirect_back(fallback_location: root_path)
  end

  def find_emojis
    EmojiFiller.call(@message)
  end

  def trigger_notifications
    return unless @message.user_id == current_user.id
    conversation = Conversation.find(@message.conversation_id)
    send_notification unless current_user.conversations.include?(conversation)
  end

  def send_notification
    flash[:success] = "You have a new message at conversation: #{@conversation.title}"
  end

  def message_params
    params.require(:message).permit(:content, :conversation_id, :image, :user_id)
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end
