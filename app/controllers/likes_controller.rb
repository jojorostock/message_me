class LikesController < ApplicationController
    before_action :find_message

    def create
        @message.likes.create(user_id: current_user.id)
        redirect_to root_path
    end

    def destroy
        like = @message.likes.where(user_id: current_user.id).first
        like.destroy
        redirect_to root_path
    end


    private
    def find_message
        @message = Message.find(params[:message_id])
    end
end
