require 'rails_helper'

RSpec.describe 'List all bucketlist items', type: :request do
    let!(:user) { create(:user) }
    let!(:bucket) { create(:bucketlist, user: user) }
    let!(:bucket_id) { bucket.id }
    let!(:items) { create_list(:item, 20, bucketlist: bucket) }
    let(:header) { valid_headers(user) }
    let(:params) {}

    let!(:request) { get "/bucketlists/#{bucket_id}/items", headers: header }

    subject { response }

    it_behaves_like('a http response', 200)

    context 'when the user has no items in that bucketlist' do
      before(:each) do
        bucket.items.destroy_all
        get "/bucketlists/#{bucket_id}/items", params: params, headers: header
      end

      it 'returns zero items' do
        expect(json).to be_empty
      end
    end

    include_context(
      'when resource id does not exist for that user',
      'bucketlist',
      bucket_id: -1
    )
    include_context 'when authorization token is not included'
end
