class MessagesController < ApplicationController
  before_action :require_login, :conversation
  before_action :message, except: :create
  after_action  :notification, only: :create

  def create
    @message = @conversation.messages.create(message_params)
    @message.fill_emojis
    redirect_to conversation_path(@conversation)
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

  def remove_asset
    @message.image.purge
    redirect_to edit_conversation_message_path @message
  end

  private

  def notification
    send_new_message_notification_email
    unless @message.user_id == current_user.id
      conversation = Conversation.find(@message.conversation_id)
      send_notification if current_user.conversations.include?(conversation)
    end
  end

  def send_notification
    flash[:success] = "You have a new message at conversation: #{@conversation.title}"
  end

  def send_new_message_notification_email
    @conversation.users.each do |user|
      unless user == current_user
        ConversationMailer.new_message_email(user, @conversation).deliver_now
      end
    end
  end

  def message_params
    params.require(:message).permit(:content, :conversation_id, :image, :user_id)
  end

  def message
    @message = Message.find(params[:id])
  end

  def conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end
