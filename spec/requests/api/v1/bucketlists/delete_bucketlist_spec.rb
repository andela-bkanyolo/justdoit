require 'rails_helper'

RSpec.describe 'Delete a bucketlist', type: :request do
  let!(:user) { create(:user) }
  let!(:bucket) { create(:bucketlist, user: user) }
  let(:id) { bucket.id }
  let(:header) { valid_headers(user) }

  let!(:request) { delete "/bucketlists/#{id}", params: {}, headers: header }
  subject { response }

  context 'when bucketlist id exists for that user' do
    it_behaves_like(
      'a http response',
      200,
      Messages.resource_deleted('Bucketlist')
    )

    it 'Deletes the provided bucketlist' do
      expect(user.bucketlists).to_not include bucket
    end
  end

  include_context('when resource id does not exist for that user', 'bucketlist')
  include_context 'when authorization token is not included'
end
