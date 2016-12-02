RSpec.shared_examples 'a paginable resource' do
  context 'when pagination params are missing' do
    it 'returns only the first 20 by default' do
      expect(json.count).to eq 20
    end
  end

  context 'when pagination params are invalid' do
    let(:params) { { page: -1, limit: -10 } }
    it 'returns only the first 20 by default' do
      expect(json.count).to eq 20
    end
  end

  context 'when pagination params are set with limit <= 100' do
    let(:params) { { page: 1, limit: 1 } }
    it 'returns results limited by limit' do
      expect(json.count).to eq 1
    end
  end

  context 'when pagination params are set with limit > count' do
    let(:params) { { page: 1, limit: 120 } }
    it 'returns all for that page' do
      expect(json.count).to eq 20
    end
  end
end
