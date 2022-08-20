class V1::ApplicationsController < ApplicationController
    def index
        @applications = Application.all
        render json: @applications.as_json(only:[:name,:authentication_token]), status: :ok
    end
    def create
        @application = Application.new(application_params)
        @application.save
        render json: @application.as_json(only:[:name,:authentication_token]), status: :created
    end
    def destroy
        @application = Application.where(authentication_token:params[:authentication_token]).first
        if @application.destroy
            head(:ok)
        else
            head(:unprocessable_entity)
        end
    end
    def show
        @application = Application.where(authentication_token:params[:authentication_token]).first
        if @application
            render json: @application.as_json(only:[:name,:authentication_token]), status: :ok
        else
            head(:unauthorized)
        end
    end
    def update
        @application = Application.where(authentication_token:params[:authentication_token]).first
        if @application.update_attributes(application_params)
           head(:ok)
        else
            head(:unauthorized)
        end
        
    end
    
    private 
    def application_params
        params.require(:application).permit(:name)
    end
end
