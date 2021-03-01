class MessageDestroyer < ApplicationService
  def initialize(message)
    @message = message
  end

  def call
    @message.removed = true
    @message.content = ''
    @message.image.purge
    if @message.save
      OpenStruct.new({success?: true})
    else
      OpenStruct.new({success?: false})
    end
  end
end
