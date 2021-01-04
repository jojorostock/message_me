class UserController < ApplicationController

    def show
        @user = User.find(params[:id])
        if @user === current_user
            redirect_to profile_path
        end
        @messages = @user.messages
        @friendships = @user.friendships
        @curr = current_user
        @likes = []
        @user.likes.each do |like|
            @likes.push(Message.where(id: like.message_id).first)
        end
    end

end