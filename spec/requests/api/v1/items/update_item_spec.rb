require 'rails_helper'

RSpec.describe 'Update a bucketlist item', type: :request do
  let!(:user) { create(:user) }
  let!(:bucket) { create(:bucketlist, user: user) }
  let!(:bucket_id) { bucket.id }
  let!(:item) { create(:item, name: 'Old Name', bucketlist: bucket) }
  let(:id) { item.id }
  let(:header) { valid_headers(user) }
  let(:params) { { name: 'New Name' } }

  let!(:request) { put "/bucketlists/#{bucket_id}/items/#{id}", params: params, headers: header }
  subject { response }

  context 'when bucketlist id exists for that user' do
    context 'when bucketlist item id exists' do
      context 'with valid parameters' do
        it_behaves_like('a http response', 200)

        it 'returns the updated bucketlist' do
          expect(json['id']).to eq item.id
          expect(json['name']).to eq 'New Name'
        end

        it 'updates the bucketlist on the database' do
          new_item = user.bucketlists.find(bucket_id).items.find(id)
          expect(new_item.name).to eq 'New Name'
        end
      end

      context 'with invalid parameters' do
        let(:params) { { name: nil } }

        it_behaves_like(
          'a http response',
          422,
          "Validation failed: Name can't be blank"
        )

        it 'does not update the bucketlist item on the database' do
          expect(item.name).to eq 'Old Name'
        end
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
