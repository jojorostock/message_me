class UserController < ApplicationController

    def show
        @user = User.find(params[:id])
        if @user === current_user
            redirect_to profile_path
        end

        @message = Message.new()
        @friend = @user.id

        @base_url = '/user/'+@user.id.to_s+'/'

        @messages = Message.where(user: @user.id, friend_id: current_user.id)+Message.where(user: current_user.id, friend_id: @user.id)
        # @user.messages.each do |m|
        #     @messages.push(m)
        # end 
        @messages = @messages.sort_by{|m| m.created_at.to_i}
        if params[:sort] === "message_sent"
            @messages = @messages.sort_by{|m| -m.created_at.to_i}
        elsif params[:sort] === "message_likes"
            @messages = @messages.sort_by{|m| -m.likes.count}    
        end

        @friendships = @user.friendships
        if params[:sort] ==="friends_since"
            @friendships = @friendships.sort_by{|f| -f.created_at.to_i}
        elsif params[:sort] ==="friends_name"
            @friendships = @friendships.sort_by{|f| User.where(id: f.friend_id).first.username.upcase}
        end
        
        @curr = current_user
        @likes = []
        @user.likes.each do |like|
            @likes.push(Message.where(id: like.message_id).first)
        end
        if params[:sort] === "liked_on"
            @likes = @likes.sort_by{|l| -l.created_at.to_i}
        elsif params[:sort] === "liked_user"
            @likes = @likes.sort_by{|l| l.user.username}
        end
    end

end