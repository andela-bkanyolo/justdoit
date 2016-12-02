require 'rails_helper'

RSpec.describe 'Show a bucketlist', type: :request do
  let!(:user) { create(:user) }
  let!(:bucket) { create(:bucketlist, user: user) }
  let(:id) { bucket.id }
  let(:header) { valid_headers(user) }

  let!(:request) { get "/bucketlists/#{id}", params: {}, headers: header }
  subject { response }

  context 'when bucketlist id exists for that user' do
    it_behaves_like('a http response', 200)

    it 'returns the provided bucketlist' do
      expect(json['name']).to eq bucket.name
      expect(json['id']).to eq bucket.id
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
