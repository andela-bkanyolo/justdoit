RSpec.shared_examples 'a http response' do |status, message = nil|
  it 'returns a status code #{status}' do
    expect(response.status).to eq(status)
  end

  it 'returns corresponding message' do
    expect(json['message']).to eq(message)
  end if message
end

RSpec.shared_examples 'an unathorized response' do
  let(:header) { invalid_headers }
  it_behaves_like 'a http response', 401, Messages.missing_token
end
