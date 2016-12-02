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
      before(:each) do
        get '/auth/logout', headers: header
      end
      context 'when authorization token is valid' do
        let(:header) { valid_headers(user) }

        it_behaves_like('a http response', 200, Messages.user_logged_out)

        it 'removes the token from the database' do
          user_tokens = user.tokens.pluck(:token)
          expect(user_tokens).to_not include(header[:authorization])
        end
      end

      context 'when authorization token is already logged out' do
        let(:header) { valid_headers(user) }
        before(:each) do
          get '/auth/logout', headers: header
        end

        it_behaves_like('a http response', 401, Messages.expired_token)
      end

      context 'when user in token does not exist' do
        let(:header) { invalid_headers(invalid_user_token(-1)) }
        it_behaves_like('a http response', 404)
      end

      context 'when authorization token is expired' do
        let(:header) { invalid_headers(expired_token(user)) }
        it_behaves_like('a http response', 401, Messages.expired_token)
      end

      context 'when authorization token is invalid' do
        let(:header) { invalid_headers('1234') }
        it_behaves_like('a http response', 401, Messages.invalid_token)
      end
    end

    include_context 'when authorization token is not included' do
      before do
        get '/auth/logout'
      end
    end
  end
end
