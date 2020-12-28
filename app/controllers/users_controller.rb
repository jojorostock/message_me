class UsersController < ApplicationController

    before_action :require_user, only: [:profile, :show, :edit, :update]


    def profile
        @user = current_user
        @messages = Message.where(user_id: current_user.id)
        @friendships = Friendship.where(user_id: current_user.id)
    end
    
    def edit
        @user = current_user
    end

    def update 
        @user = current_user
        if params[:user][:username]
            isUser = User.find_by(username: params[:user][:username]) && current_user !== User.find_by(username: params[:user][:username])
            if isUser
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
                avatar: params[:user][:avatar],
                color: colors[5*rand()]
            )
            flash[:success] = "User #{@user.username} was successfully created"
            redirect_to login_path
        end
    end
end
