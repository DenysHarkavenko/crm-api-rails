require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create(:user, email: 'test@example.com', password: 'password123') }

    it 'returns authentication token on successful login' do
      post :create, params: { email: user.email, password: 'password123' }
      expect(response).to have_http_status(:created)

      user.reload
      expect(JSON.parse(response.body)['email']).to eq(user.email)
      expect(JSON.parse(response.body)['authentication_token']).to eq(user.authentication_token)
    end

    it 'returns unauthorized on invalid login' do
      post :create, params: { email: user.email, password: 'wrongpassword' }
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)['error']).to eq('User not found or invalid credentials')
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user, authentication_token: 'testtoken') }

    it 'logs out the user and returns OK' do
      request.headers['Authorization'] = "Bearer #{user.authentication_token}"
      expect(response).to have_http_status(:ok)
    end

    it 'returns unauthorized if user is not logged in' do
      delete :destroy
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
