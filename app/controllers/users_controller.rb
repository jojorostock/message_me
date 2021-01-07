class UsersController < ApplicationController

    before_action :require_user, only: [:profile, :show, :edit, :update]


    def profile
        @user = current_user

        @base_url = '/profile/'

        @sentMessages = @user.messages.where(friend_id: 0)
        if params[:sort] === "message_sent"
            @sentMessages = @sentMessages.sort_by{|m| -m.created_at.to_i}
        elsif params[:sort] === "message_likes"
            @sentMessages = @sentMessages.sort_by{|m| -m.likes.count}    
        end
        
        @friendships = @user.friendships
        if params[:sort] ==="friends_since"
            @friendships = @friendships.sort_by{|f| f.created_at.to_i}
        elsif params[:sort] ==="friends_name"
            @friendships = @friendships.sort_by{|f| User.where(id: f.friend_id).first.username.upcase}
        end

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
    
    def edit
        @user = current_user
    end

    def update 
        @user = current_user
        if params[:user][:username]
            isUser = User.find_by(username: params[:user][:username])
            if isUser && User.find_by(username: params[:user][:username]).id != current_user.id
                flash[:error] = "A user with the username: #{params[:user][:username]} already exists try another username"
                render 'edit'
                return
            else
                @user.username = params[:user][:username]
            end
        end
        if params[:user][:avatar]
            @user.avatar = params[:user][:avatar]
        end
        @user.save
        redirect_to profile_path
    end


    def new

    end

    def show
        if !params[:sort]
            @users = User.all
        elsif params[:sort] == 'name'
            @users = User.all.sort_by{|u| u.username.upcase}
        elsif params[:sort] == 'messages'
            @users = User.all.sort_by{|u| -u.messages.count}
        elsif params[:sort] == 'friends'
            @users = User.all.sort_by{|u| -u.friendships.count}
        elsif params[:sort] == 'is_friends'
            @users = User.all.sort_by{|u| current_user.friendships.any? {|f| f.friend_id === u.id} ? 0 : 1}
        else
            @users = User.all
        end
        @user = current_user
        @friendships = current_user.friendships
    end

    def create
        # passw = params[:user][:password]
        name = params[:user][:username]
        isUser = User.find_by(username: name)
        if isUser
            flash[:error] = "A user with the username: #{name} already exists try another username"
            render 'new'

        else
            colors = ['red', 'blue', 'green', 'orange', 'purple']
            @user = User.create(
                username: name,
                password: params[:user][:password],
                avatar: params[:user][:avatar],
                color: colors[5*rand()]
            )
            flash[:success] = "User #{@user.username} was successfully created"
            redirect_to login_path
        end
    end
end
