class UserController < ApplicationController
    def index 
        @users = User.all #테이블의 모든 정보를 조회해서 @users에 담음
    end
    
    def new

    end

    def create
        u1 = User.new
        u1.user_name = params[:name]
        u1.password = params[:password]
        u1.save
        redirect_to "/user/#{u1.id}"
    end
    
    def show
        @user = User.find(params[:id])
    end
end
