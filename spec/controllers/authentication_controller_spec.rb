require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  describe 'POST #login' do
    context 'when params are valid' do
      before(:each) do
        user = create(:user, password: 'password')
        post :login, params: {
          email: user.email,
          password: 'password'
        }
      end

      it_behaves_like('a http response', 200, Messages.user_logged_in)

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when params are invalid' do
      before(:each) do
        post :login
      end

      it_behaves_like('a http response', 401, Messages.user_not_logged_in)
    end
  end

  describe 'GET #logout', type: :request do
    context 'when authorization token is included' do
      let(:user) { create(:user) }
      let(:header) { auth_headers(user) }

      before(:each) do
        get '/auth/logout', headers: header
      end

      it_behaves_like('a http response', 200, Messages.user_logged_out)

      it 'removes the token from the database' do
        user_tokens = user.tokens.pluck(:token)
        expect(user_tokens).to_not include(header[:authorization])
      end
    end

    include_context 'when authorization token is not included' do
      before do
        get '/auth/logout'
      end
    end
  end
end
