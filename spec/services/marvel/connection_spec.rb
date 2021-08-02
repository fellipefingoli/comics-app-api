# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Marvel::Connection, type: :service do
  describe '.request' do
    subject { described_class.request('comic') }

    it { is_expected.to be_an_instance_of(RestClient::Resource) }
  end
end
