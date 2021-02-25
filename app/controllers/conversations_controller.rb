class ConversationsController < ApplicationController
  before_action :require_login
  before_action :set_conversation, only: %i!show edit update destroy join!
  after_action  :add_users_to_conversation, only: :create

  def index
    @conversations = Conversation.all
  end

  def new
    @users = User.all
    @conversation = Conversation.new
  end

  def show
    @user_names = user_names
    @message = Message.new
  end

  def edit
  end

  def join
    @conversation.users << current_user
    redirect_to conversation_path(@conversation)
  end

  def update
    # refactor
    @conversation.update(conversation_params) unless params[:conversation][:name].empty?
    redirect_to conversation_path(@conversation)
  end

  def create
    @conversation = current_user.conversations.create
    # ConversationMailer.new_conversation_email(receiver).deliver_now
    SendConversationsSummaryEmailJob.set(wait: 10.seconds).perform_later(current_user)
    render :edit
  end

  def destroy
    @conversation.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def add_users_to_conversation
    params[:conversation][:user_ids].each do |user_id|
      @conversation.users << User.find(user_id) unless user_id.blank?
    end
  end
  def user_names
    Hash[User.all.collect { |user| [user.id, user.username] }]
  end

  def conversation_params
    params.require(:conversation).permit(:user_ids, :name, :status)
  end

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end
end
