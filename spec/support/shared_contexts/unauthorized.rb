RSpec.shared_context 'when authorization token is not included' do
  it 'returns a status code 401' do
    expect(response.status).to eq(401)
  end

  it 'renders a missing token message' do
    expect(json['message']).to match(Messages.missing_token)
  end
end
