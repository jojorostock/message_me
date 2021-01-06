class MessagesController < ApplicationController
    
    before_action :require_user
    
    def create
        message = current_user.messages.build(message_params)
        myTagId = 'message-container'
        friendTagId = nil
        if message.friend_id != 0
            myTagId = 'message-container-friend-'+message.friend_id.to_s+'-from-'+message.user.id.to_s
            friendTagId = 'message-container-friend-'+message.user.id.to_s+'-from-'+message.friend_id.to_s
        end

        puts("here " + myTagId)
        if message.save
            ActionCable.server.broadcast "chatroom_channel", {mod_message: message_render(message), id: myTagId, friendId: friendTagId}
        end
    end
    
    private
    
    def message_params
       params.require(:message).permit(:body, :photo, :friend_id)
    end

    def message_render(message)
        render(partial: 'message', locals: {message: message})
    end
    
end
