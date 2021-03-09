class ConversationsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :show_errors
  rescue_from Conversation::DefaultEmoji, with: :default_emoji
  before_action :require_login, except: :profile
  before_action :set_conversation, only: %i!show edit update destroy join profile!
  after_action  :add_users_to_conversation, only: [:create, :update]
  after_action  :set_emoji, only: [:create, :update]

  def profile
    raise User::NotAuthorized unless ConversationGuard.call(@conversation, current_user).success?
  end

  def shared_conversation
    redirect_to conversation_path(params[:conversation_id])
  end

  def index
    @public_conversations_to_join = ConversationsQuery
      .new.only_public.exclude(current_user.conversations.ids)
  end

  def start_conversation
    @users = User.where.not(id: current_user.id)
  end

  def new
    @conversation ||= params[:user_ids].nil? ?
      Conversation.new : Conversation.new(user_ids: params[:user_ids])
  end

  def show
    @message = Message.new
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
  end

  def join
    @conversation.users << current_user
    redirect_to @conversation
  end

  def update
    @conversation.update(conversation_params)
    if @conversation.save
      redirect_to @conversation
    else
      render :edit
    end
  end

  def create
    @conversation = current_user.conversations.create(conversation_params)
    if @conversation.save
      redirect_to @conversation
    else
      render :new
    end
  end

  def destroy
    @conversation.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def default_emoji
    flash[:error] = "You provided an invalid emoji! A default one (❤) has been setted"
  end

  def show_errors
    flash[:error] = "Invalid conversation!"
    redirect_back(fallback_location: root_path)
  end

  def set_emoji
    EmojiSetter.call(@conversation)
    ensure
      add_users_to_conversation
  end

  def add_users_to_conversation
    @conversation.users = User.where(id: params[:conversation][:user_ids])
    @conversation.users << current_user
  end

  def conversation_params
    params.require(:conversation).permit(:user_id, :name, :description, :emoji, :status, :user_ids)
  end

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end
end
