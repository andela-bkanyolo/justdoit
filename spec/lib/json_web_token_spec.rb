require 'rails_helper'

RSpec.describe JsonWebToken do
  let(:payload) { { id: 1 } }

  describe '#encode' do
    it 'returns a jwt token' do
      expect(described_class.encode(payload)).to_not be nil
    end
  end

  describe '#decode' do
    context 'when token is valid' do
      let(:token) { described_class.encode(payload) }

      it 'returns the payload' do
        expect(described_class.decode(token)[:id]).to eq 1
      end
    end

    context 'when token is expired' do
      let(:token) { described_class.encode(payload, Time.now - 10) }

      it 'raises not authorized error' do
        expect { described_class.decode(token) }.to raise_error(
          ExceptionHandler::NotAuthorized,
          Messages.expired_token
        )
      end
    end

    context 'when token is invalid' do
      it 'raises not authorized error' do
        expect { described_class.decode('1234') }.to raise_error(
          ExceptionHandler::NotAuthorized,
          Messages.invalid_token
        )
      end
    end
  end
end
