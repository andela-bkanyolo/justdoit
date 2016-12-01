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

  describe 'GET #logout' do
    let(:user) { create(:user) }

    context 'when authorization succeeds' do
      before(:each) do
        get :logout, params: {test: "test"}
        request.headers["authorization"] = auth_headers["authorization"]
      end

      it {binding.pry}

      it_behaves_like('a http response', 200, Messages.user_logged_out)
    end

    context 'when authorization fails' do
      before(:each) do
        get :logout
      end

      it_behaves_like('a http response', 401, Messages.missing_token)
    end
  end
end
