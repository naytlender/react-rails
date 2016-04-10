module V1
  # Session Serializer
  class SessionSerializer < ActiveModel::Serializer
    attributes :user_id, :username, :email, :token_type, :access_token

    def user_id
      object.id
    end

    def token_type
      'Token'
    end
  end
end
