RSpec.shared_context 'when authorization token is not included' do
  let(:header) { invalid_auth_headers }
  it_behaves_like 'a http response', 401, Messages.missing_token
end
