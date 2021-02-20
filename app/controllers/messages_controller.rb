class MessagesController < ApplicationController
  def create
    # byebug
    conversation = Conversation.find(6)
    conversation.messages.create(message_params.merge({user_id: current_user.id}))

    # if @message.save
    #   redirect
    # end
  end

  private

  def message_params
    # params.require(:message).permit(:content)
    params.permit(:content)
  end
end
