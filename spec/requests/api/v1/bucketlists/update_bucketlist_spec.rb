require 'rails_helper'

RSpec.describe 'Update a bucketlist', type: :request do
  let!(:user) { create(:user) }
  let!(:bucket) { create(:bucketlist, name: 'Old Name', user: user) }
  let(:id) { bucket.id }
  let(:header) { auth_headers(user) }
  let(:params) { { name: 'New Name' } }

  let!(:request) { put "/bucketlists/#{id}", params: params, headers: header }
  subject { response }

  context 'when bucketlist id exists for that user' do
    context 'with valid parameters' do
      it_behaves_like('a http response', 200)

      it 'returns the updated bucketlist' do
        expect(json['id']).to eq bucket.id
        expect(json['name']).to eq 'New Name'
      end

      it 'updates the bucketlist on the database' do
        new_list = user.bucketlists.find(id)
        expect(new_list.name).to eq 'New Name'
      end
    end

    context 'with invalid parameters' do
      let(:params) { { name: nil } }

      it_behaves_like(
        'a http response',
        422,
        "Validation failed: Name can't be blank"
      )

      it 'does not update the bucketlist on the database' do
        expect(bucket.name).to eq 'Old Name'
      end
    end
  end

  context 'when bucketlist id does not exist for that user' do
    let(:id) { -1 }

    it_behaves_like(
      'a http response',
      404,
      Messages.resource_not_found('bucketlist')
    )
  end

  it_behaves_like 'an unathorized response'
end
