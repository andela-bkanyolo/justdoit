require 'rails_helper'

RSpec.describe AuthorizationService do
  let(:user) { create(:user) }
  let(:invalid_user) { build(:user) }
  let(:invalid_token) { invalid_user_token(invalid_user.id) }
  let(:valid_header) { { 'Authorization' => token(user).token } }
  let(:invalid_header) do
    { 'Authorization' => invalid_user_token(invalid_user.id) }
  end

  describe '#authorize' do
    context 'when header includes authorization token' do
      context 'when user in token is valid' do
        subject { described_class.new(valid_header) }

        it 'returns the user and token' do
          expect(subject.authorize[:user]).to eq user
        end
      end

      context 'when user in token does not exist' do
        subject { described_class.new(invalid_header) }

        it 'raises record not found error' do
          expect { subject.authorize }.to raise_error(
            ExceptionHandler::UserNotFound,
            Messages.user_not_found
          )
        end
      end
    end

    context 'when header does not include authorization token' do
      subject { described_class.new }

      it 'raises not authorized error' do
        expect { subject.authorize }.to raise_error(
          ExceptionHandler::NotAuthorized,
          Messages.missing_token
        )
      end
    end
  end
end
