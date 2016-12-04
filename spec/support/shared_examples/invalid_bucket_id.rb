RSpec.shared_examples 'an invalid id' do |resource, bucket_id|
  if bucket_id
    let(:bucket_id) { -1 }
  else
    let(:id) { -1 }
  end

  it_behaves_like(
    'a http response',
    404,
    Messages.resource_not_found(resource)
  )
end
