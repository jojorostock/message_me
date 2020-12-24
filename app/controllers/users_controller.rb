class UsersController < ApplicationController

    def profile
        @user = current_user
        @messages = Message.where(user_id: current_user.id)
        @friendships = Friendship.where(user_id: current_user.id)
    end
    
    
    def new

    end

    def show
        @users = User.all
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
                color: colors[5*rand()]
            )
            flash[:success] = "User #{@user.username} was successfully created"
            redirect_to login_path
        end
    end

    def otherProfile
        @user = User.find(params[:id])
        @messages = Message.where(user_id: @user.id)
        @friendships = Friendship.where(user_id: @user.id)
        @curr = current_user
    end
end
