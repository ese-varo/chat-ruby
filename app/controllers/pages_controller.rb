class PagesController < ApplicationController
  def index
    @user = current_user
    @public_conversations = ConversationsQuery.new.public_more_active
    redirect_to conversations_path if current_user
  end
end
