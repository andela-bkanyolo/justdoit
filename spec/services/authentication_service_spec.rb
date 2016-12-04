require 'rails_helper'

RSpec.describe AuthenticationService do
  let(:user) { create(:user) }
  let(:new_user_attrs) { attributes_for(:user) }
  let(:invalid_user_attrs) { attributes_for(:user, email: nil) }

  describe '#signup' do
    context 'when correct user details are supplied' do
      subject { described_class.new(new_user_attrs) }

      it 'creates a new user' do
        expect { subject.signup }.to change { User.count }.by(1)
      end
    end

    context 'when incorrect user details are supplied' do
      subject { described_class.new(invalid_user_attrs) }

      it 'raises an active record error' do
        expect { subject.signup }.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end

  describe '#login' do
    context 'when correct user details are supplied' do
      subject { described_class.new(new_user_attrs) }

      it 'returns some token' do
        create(:user, new_user_attrs)
        expect(subject.login).to_not be nil
      end

      it 'destroys all previous tokens' do
        user = create(:user, new_user_attrs)
        subject.login
        expect(user.tokens.count).to eq 1
      end
    end

    context 'when incorrect user details are supplied' do
      subject { described_class.new(invalid_user_attrs) }

      it 'raises access denied error' do
        expect { subject.login }.to raise_error(
          ExceptionHandler::AccessDenied,
          Messages.user_not_logged_in
        )
      end
    end
  end

  describe '#logout' do
    subject { described_class.new(new_user_attrs) }

    it 'deletes specified token' do
      token = user.tokens.create(token: Faker::Code.asin)
      subject.logout(token.token)
      expect(Token.all).to_not include token
    end
  end
end
