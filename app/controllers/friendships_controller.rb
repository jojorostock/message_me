class FriendshipsController < ApplicationController
    
    def create
        Friendship.create(user_id: current_user.id, friend_id: params[:friend_id])
        redirect_to profile_path
    end

    def destroy
        friendship = current_user.friendships.where(friend_id: params[:friend_id]).first
        friendship.destroy
        redirect_to profile_path
    end
    
end