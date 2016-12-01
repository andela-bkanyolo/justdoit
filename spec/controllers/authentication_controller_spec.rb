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

      it_behaves_like('a http response', 200, 'Successfully logged in')

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when params are invalid' do
      before(:each) do
        post :login, params: {}
      end

      it_behaves_like(
        'a http response',
        401,
        'Log in email or password incorrect'
      )
    end
  end
end
