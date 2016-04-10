module V1
  # Sessions controller
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    # POST /v1/login
    def create
      @user = User.find_for_database_authentication(email: params[:email])
      return invalid_login_attempt unless @user

      if @user.valid_password?(params[:password])
        sign_in :user, @user
        render json: SessionSerializer.new(@user).as_json(root: false)
      else
        inlalid_login_attempt
      end
    end

    # DELETE /v1/loguot
    def destroy
      @user = current_user

      sign_out :user, @user
      render json: { success: 'user signed out' }
    end

    private

    def invalid_login_attempt
      warden.custom_failure!
      render json: { error: 'invalid login attempt' },
             status: :unprocessable_entity
    end
  end
end
