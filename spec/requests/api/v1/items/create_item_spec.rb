require 'rails_helper'

RSpec.describe 'Create an item', type: :request do
  let!(:user) { create(:user) }
  let!(:bucket) { create(:bucketlist, user: user) }
  let(:params) { attributes_for(:item, bucketlist: bucket) }
  let(:header) { auth_headers(user) }

  let!(:request) do
    post "/bucketlists/#{bucket.id}/items", params: params, headers: header
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

  context 'when bucketlist id does not exist for that user' do
    let!(:request) do
      post "/bucketlists/-1/items", params: params, headers: header
    end

    it_behaves_like(
      'a http response',
      404,
      Messages.resource_not_found('bucketlist')
    )
  end

  it_behaves_like 'an unathorized response'
end
