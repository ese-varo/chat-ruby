class ConversationGuard < ApplicationService
  def initialize(conversation, user)
    @conversation = conversation
    @user = user
  end

  def call
    if @conversation.users.include?(@user) || @conversation.public?
      OpenStruct.new({success?: true})
    else
      OpenStruct.new({success?: false})
    end
  end
end
