class HeavyliftingJob < ApplicationJob
  queue_as :default

  def perform(chat_number,message)
    @message = Message.new(chat_id:chat_number,message:message)
    @message.save
  end
end
