class AuthenticationController < ApplicationController
    skip_before_action :authenticate, only: [:login]
  
    SECRET_KEY = Rails.application.credentials.secret_key_base # Pode ser qualquer chave secreta
  
    def login
      @user = User.find_by(username: params[:user][:username])
      
      if @user && @user.authenticate(params[:user][:password])
        token = generate_token(@user.id)
        render json: {
          username: @user.username,
          token: token
        }
      else
        render json: { message: "Authentication failed" }, status: :unauthorized
      end
    end
  
    private
  
    def generate_token(user_id)
      payload = { user_id: user_id, exp: 24.hours.from_now.to_i } # Expiração de 24 horas
      JWT.encode(payload, SECRET_KEY)
    end
  end
  