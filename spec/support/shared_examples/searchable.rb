RSpec.shared_examples 'a searchable resource' do
  context 'when the query provided matches' do
    let(:query) { create(:bucketlist, user: user) }
    let(:params) { { q: query.name } }
    it 'finds and returns queried bucket' do
      expect(json.map { |bucketlist| bucketlist['name'] }).to include query.name
    end
  end

  context 'when the query provided does not match' do
    let(:params) { { q: Faker::Code.asin } }

    it 'finds and returns zero items' do
      expect(json).to be_empty
    end
  end
end
