require 'rails_helper'

RSpec.describe 'List all bucketlists', type: :request do
  let!(:user) { create(:user) }
  let!(:bucket) { create_list(:bucketlist, 20, user: user) }
  let(:header) { auth_headers(user) }
  let(:params) {}

  let!(:request) { get '/bucketlists', params: params, headers: header }

  subject { response }

  it_behaves_like 'a http response', 200

  context 'when pagination params are missing' do
    it 'returns only the first 20 bucketlists by default' do
      expect(json.count).to eql 20
    end
  end

  context 'when pagination params are invalid' do
    let(:params) { { page: -1, limit: -10 } }
    it 'returns only the first 20 bucketlists by default' do
      expect(json.count).to eq 20
    end
  end

  context 'when pagination params are set with limit <= 100' do
    let(:params) { { page: 1, limit: 10 } }
    it 'returns bucketlists limited by limit' do
      expect(json.count).to eq 10
    end
  end

  context 'when pagination params are set with limit > count' do
    let(:params) { { page: 1, limit: 120 } }
    it 'returns all bucketlists for that page' do
      expect(json.count).to eq 20
    end
  end

  it_behaves_like 'an unathorized response'
end
