require 'rails_helper'

RSpec.describe 'List all bucketlists', type: :request do
  let!(:user) { create(:user) }
  let!(:bucket) { create_list(:bucketlist, 20, user: user) }
  let(:header) { valid_headers(user) }
  let(:params) {}

  let!(:request) { get '/bucketlists', params: params, headers: header }

  subject { response }

  it_behaves_like('a http response', 200)

  it_behaves_like 'a paginable resource'

  it_behaves_like 'a searchable resource'

  context 'when the user has no bucketlists' do
    before(:each) do
      user.bucketlists.destroy_all
      get '/bucketlists', params: params, headers: header
    end

    it 'returns zero items' do
      expect(json).to be_empty
    end
  end

  include_context 'when authorization token is not included'
end
