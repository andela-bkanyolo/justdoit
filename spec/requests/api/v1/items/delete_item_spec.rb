require 'rails_helper'

RSpec.describe 'Delete a bucketlist item', type: :request do
  let!(:user) { create(:user) }
  let!(:bucket) { create(:bucketlist, user: user) }
  let!(:bucket_id) { bucket.id }
  let!(:item) { create(:item, bucketlist: bucket) }
  let(:id) { item.id }
  let(:header) { valid_headers(user) }

  let!(:request) { delete "/bucketlists/#{bucket_id}/items/#{id}", params: {}, headers: header }
  subject { response }

  context 'when bucketlist id exists for that user' do
    context 'when bucketlist item id exists' do
      it_behaves_like(
        'a http response',
        200,
        Messages.resource_deleted('Item')
      )

      it 'Deletes the provided bucketlist item' do
        expect(bucket.items).to_not include item
      end
    end
  end

  include_context('when resource id does not exist for that user', 'item')
  include_context(
    'when resource id does not exist for that user',
    'bucketlist',
    bucket_id: -1)
  include_context 'when authorization token is not included'
end
