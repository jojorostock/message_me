class LikesController < ApplicationController
    before_action :find_message
    def create
        @message.likes.create(user_id: current_user.id)
        puts("im creating")
    end

    def destroy
        like = @message.likes.where(user_id: current_user.id)
        puts(like)
        like.destroy
    end


    private
    def find_message
        @message = Message.find(params[:message_id])
    end
end
