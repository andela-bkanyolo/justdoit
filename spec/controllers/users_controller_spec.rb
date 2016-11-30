require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'when params are valid' do
      before(:each) do
        post :create, params: {
          user: attributes_for(:user)
        }
      end

      it_behaves_like 'a http response', 201, 'User successfully created'

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when params are invalid' do
      before(:each) do
        post :create, params: { user: {} }
      end

      it_behaves_like 'a http response', 422, 'Error creating user'
    end
  end
end
