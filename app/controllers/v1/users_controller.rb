module V1
  # Users Controller
  class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create]

    # POST /v1/users
    # Creates an user
    def create
      @user = User.new user_params

      if @user.save
        render json: V1::SessionSerializer.new(@user).as_json(root: false)
      else
        render json: { error: t('user_create_error') }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      puts params
      params.require(:user).permit(:email, :username, :password, :password_confirmation)
    end
  end
end
