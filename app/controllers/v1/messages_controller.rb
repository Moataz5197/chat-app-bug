class V1::MessagesController < ApplicationController
    def index
        if @application = Application.where(authentication_token:params[:application_authentication_token]).first
            @messages = Message.where(chat_id:params[:chat_number]).all
            render json: @messages.as_json(only:[:message]), status: :ok
        else
            head(:unauthorized)
        end
    end

    def create
        if @application = Application.where(authentication_token:params[:application_authentication_token]).first
            # sidekiq handles everything
            if @chat = Chat.where(chat_number:params[:chat_number],application_id:@application.id)
                # 2 jobs 1 for fast increminting  and one take time to make db presist

                render @chat.as_json(), status: :created
                chat_number = params[:chat_number]
                message = params[:message]
                SmallliftingJobJob.perform_now(chat_number)
                HeavyliftingJob.perform_later(chat_number,message)
                
            else
                head(:unprocessable_entity)
            end
            
        else
            head(:unauthorized)
        end

    end
    def destroy

    end
    def update
    end

    def show
    end

    private 
    def messages_params
        params.require(:message).permit(:message)
    end
end