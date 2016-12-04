RSpec.shared_context 'when resource id does not exist for that user' do |resource, bucket_id = nil|
  it_behaves_like('an invalid id', resource, bucket_id)
end
