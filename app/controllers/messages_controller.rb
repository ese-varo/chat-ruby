class MessagesController < ApplicationController
  before_action :require_login, :set_conversation
  before_action :set_message, except: :create
  # after_action  :trigger_notifications, only: :create

  def create
    @message = @conversation.messages.create(message_params)
    @message.fill_emojis
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
    @message.remove
    @message.image.purge
    @message.save
    redirect_to @conversation
  end

  private

  def trigger_notifications
    send_new_message_notification_email

    return unless @message.user_id == current_user.id
    conversation = Conversation.find(@message.conversation_id)
    send_notification unless current_user.conversations.include?(conversation)
  end

  def send_notification
    flash[:success] = "You have a new message at conversation: #{@conversation.title}"
  end

  def send_new_message_notification_email
    @conversation.users.each do |user|
      next if user == current_user
      ConversationMailer.new_message_email(user, @conversation).deliver_now
    end
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
