require 'rails_helper'

RSpec.describe 'Create a bucketlist', type: :request do
  let(:user) { create(:user) }
  let(:params) { attributes_for(:bucketlist, user: user) }
  let(:header) { valid_headers(user) }

  let!(:request) {
    post '/bucketlists', params: params, headers: header
  }

  subject { response }

  context 'when params are valid' do
    it_behaves_like('a http response', 201)

    it 'changes the Bucketlist model count by 1' do
      expect(Bucketlist.count).to eq 1
    end

    it 'renders the created bucketlist' do
      expect(json['name']).to eq params[:name]
    end
  end

  context 'when params are invalid' do
    let(:params) {}

    it_behaves_like(
      'a http response',
      422,
      "Validation failed: Name can't be blank"
    )
  end

  include_context 'when authorization token is not included'
end
