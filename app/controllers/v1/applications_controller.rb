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
    def destory
        @application = Application.where(id:params[:id]).first
        if @application.destory
            head(:ok)
        else
            head(:unprocessable_entity)
        end
    end
    def show
        
    end
    def update
        
    end
    
    private 
    def application_params
        params.require(:application).permit(:name)
    end
end
