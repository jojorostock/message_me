class UserController < ApplicationController

    def show
        @user = User.find(params[:id])
        @messages = @user.messages
        @friendships = @user.friendships
        @curr = current_user
    end

end