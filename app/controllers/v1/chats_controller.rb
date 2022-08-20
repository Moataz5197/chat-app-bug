class V1::ChatsController < ApplicationController

    def index
        if @application = Application.where(authentication_token:params[:application_authentication_token]).first
            @chats = Chat.all
            render json: @chats.as_json(only:[:chat_number]), status: :ok
        else
            head(:unauthorized)
        end
    end

    def create
        if @application = Application.where(authentication_token:params[:application_authentication_token]).first
            if @application.chat_count
                @chat = Chat.new(chat_number:@application.chat_count+1,application_id:@application.id)
                @application.chat_count += 1 
                @application.save
                @chat.save
                render json: @application.as_json(only:[:chat_count]), status: :created

            else

                @chat = Chat.new(chat_number:1,application_id:@application.id)
                @application.chat_count = 1
                @application.save
                @chat.save
                render json: @application.as_json(only:[:chat_count]), status: :created
            end
        else
            head(:unauthorized)
        end

    end
    def destroy
        if @application = Application.where(authentication_token:params[:application_authentication_token]).first
            @chat = Chat.where(chat_number:params[:number]).first
            if @chat.destroy
                head(:ok)
            else
                head(:unprocessable_entity)
            end
        else
            head(:unauthorized)
        end

    end

    # show and update for a chat is useless 

    # private 
    # def chat_params
    #     params.require(:chat).permit(:chat_number)
    # end

end