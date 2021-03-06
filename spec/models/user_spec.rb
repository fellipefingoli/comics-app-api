# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(attributes) }

  let(:attributes) { attributes_for(:user) }

  it { is_expected.to be_an_instance_of(described_class) }
end
