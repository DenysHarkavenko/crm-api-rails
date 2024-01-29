class Api::SessionsController < ApplicationController
  def create
    user = User.where(email: params[:email]).first

    if user&.valid_password?(params[:password])
      render json: user.as_json(only: [:email, :authentication_token]), status: :created
    else
      render json: { error: 'User not found or invalid credentials' }, status: :unauthorized
    end
  end

  def destroy
    if current_user
      current_user.authentication_token = nil
      if current_user.save
        sign_out(current_user)
        head(:ok)
      else
        head(:unauthorized)
      end
    else
      head(:unauthorized)
    end
  end
end
