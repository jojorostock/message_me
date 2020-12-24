class UserController < ApplicationController

    def show
        @user = User.find(params[:id])
        @messages = Message.where(user_id: @user.id)
        @friendships = Friendship.where(user_id: @user.id)
        @curr = current_user
    end

end