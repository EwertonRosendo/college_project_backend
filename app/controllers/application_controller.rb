class ApplicationController < ActionController::API
    before_action :authenticate
  
    def authenticate
      if request.headers["Authorization"]
        begin
          decoded_token = JWT.decode(token, secret)
          payload = decoded_token.first
          user_id = payload["user_id"]
          @user = User.find(user_id)
        
        rescue => exception
          render json: {
            message: "Error: #{exception.message}"
          }, status: :forbidden
        end
      else
        render json: {
          message: "No Authorization header sent"
        }, status: :forbidden
      end
    end
  
    private
  
    def secret
      Rails.application.credentials.secret_key_base
    end
  
    def token
      auth_header = request.headers["Authorization"]
      auth_header.split(" ")[1] if auth_header
    end
  
    def create_token(payload)
      JWT.encode(payload, secret)
    end
  end
  