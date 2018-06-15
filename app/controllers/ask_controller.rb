class AskController < ApplicationController
    
    def index
       @asks = Ask.all
    end
    
    def show
        @ask = Ask.find(params[:id])
    end
    
    def new
    end
    
    def delete
        ask = Ask.find(params[:id])
        ask.destroy
        redirect_to "/ask"
    end
    
    def create
        ask = Ask.new
        ask.question = params[:q]
        ask.ip_address = request.ip
        ask.region = request.location.region
        ask.save
        redirect_to "/ask"
    end
    
    def edit
       @ask = Ask.find(params[:id])
    end
    
    def update
        ask = Ask.find(params[:id])
        ask.question = params[:q]
        ask.save
        redirect_to "/ask"
    end 
end
