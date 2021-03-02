class ConversationsController < ApplicationController
  before_action :require_login
  before_action :set_conversation, only: %i!show edit update destroy join!
  after_action  :add_users_to_conversation, only: [:create, :update]

  def index
    @public_conversations_to_join = PublicConversationsQuery.call.exclude(current_user.conversations.ids)
  end

  def new
    @conversation = Conversation.new
  end

  def show
    @message = Message.new
  end

  def edit
  end

  def join
    @conversation.users << current_user
    redirect_to conversation_path(@conversation)
  end

  def update
    @conversation.update(conversation_params)
    redirect_to conversation_path(@conversation)
  end

  def create
    @conversation = current_user.conversations.create(conversation_params)
    # ConversationMailer.new_conversation_email(receiver).deliver_now
    SendConversationsSummaryEmailJob.set(wait: 10.seconds).perform_later(current_user)
    redirect_to conversation_path(@conversation)
  end

  def destroy
    @conversation.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def add_users_to_conversation
    @conversation.users = User.where(id: params[:conversation][:user_ids])
    @conversation.users << current_user
  end

  def conversation_params
    params.require(:conversation).permit(:user_id, :name, :status)
  end

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end
end
