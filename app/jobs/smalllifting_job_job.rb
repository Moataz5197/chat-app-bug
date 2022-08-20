class SmallliftingJobJob < ApplicationJob
  queue_as :quick

  def perform(chat_number)
    @chat = Chat.where(chat_number:chat_number).first
    if @chat.messages_count
        @chat.messages_count += 1
        @chat.save
    else
      @chat.messages_count = 1
      @chat.save
    end

  end
end
