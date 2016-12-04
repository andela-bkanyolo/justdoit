require 'rails_helper'

RSpec.describe ApiConstraints do
  class Request
    attr_reader :headers

    def initialize(accept)
      @headers = { 'Accept' => accept }
    end
  end

  let(:v1_request) { Request.new('application/vnd.justdoit.v1+json') }

  let(:v2_request) { Request.new('application/vnd.justdoit.v2+json') }

  describe '#matches?' do
    context 'when default is set to true' do
      subject { described_class.new(version: 1, default: true) }

      it 'returns true if default is set to true' do
        expect(subject.matches?(v1_request)).to be true
      end
    end

    context 'when default is not set to true' do
      subject { described_class.new(version: 1, default: false) }

      it 'returns true if accept header has correct version' do
        expect(subject.matches?(v1_request)).to be true
      end

      it 'returns false if accept header does not have correct version' do
        expect(subject.matches?(v2_request)).to be false
      end
    end
  end
end
