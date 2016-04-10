module V1
  # Users Controller
  class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    # GET /v1/users
    def index
      @users = User.all

      if @users
        @users.each do |u|
          render json: V1::SessionSerializer.new(u).as_json(root: false)
        end
      else
        render(json: { error: 'could not find users' },
               status: :unprocessable_entity)
      end
    end

    # GET /v1/users/:id
    def show
      @user = User.find(params[:id])

      if @user
        render json: V1::SessionSerializer.new(@user).as_json(root: false)
      else
        render(json: { error: 'could not find user' },
               status: :unprocessable_entity)
      end
    end

    # POST /v1/users
    # Creates an user
    def create
      @user = User.new user_params

      if @user.save
        render json: V1::SessionSerializer.new(@user).as_json(root: false)
      else
        render(json: { error: 'user create error' },
               status: :unprocessable_entity)
      end
    end

    # PATCH /v1/users/:id
    def update
      @user = User.find(params[:id])

      if @user.update_attributes(user_params)
        render json: V1::SessionSerializer.new(@user).as_json(root: false)
      else
        render json: { error: 'wrong parameters or attributes' }
      end
    end

    # DELETE /v1/users/:id
    def destroy
      @user = User.find(params[:id])

      if @user.destroy
        render json: { success: 'user successfully deleted' }
      else
        render json: { error: 'error deletion user' }
      end
    end

    private

    def user_params
      puts params
      params.require(:user).permit(:email, :username, :password,
                                   :password_confirmation)
    end
  end
end
