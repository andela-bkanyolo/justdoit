require 'rails_helper'

RSpec.describe 'Create an item', type: :request do
  let!(:user) { create(:user) }
  let!(:bucket) { create(:bucketlist, user: user) }
  let!(:bucket_id) { bucket.id }
  let(:params) { attributes_for(:item, bucketlist: bucket) }
  let(:header) { valid_headers(user) }

  let!(:request) do
    post "/bucketlists/#{bucket_id}/items", params: params, headers: header
  end

  context 'when bucketlist id exists for that user' do
    context 'when params are valid' do
      it_behaves_like('a http response', 201)

      it 'changes the Item model count by 1' do
        expect(Item.count).to eq 1
      end

      it 'renders the created item' do
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
  end

  include_context(
    'when resource id does not exist for that user',
    'bucketlist',
    bucket_id: -1
  )
  include_context 'when authorization token is not included'
end
