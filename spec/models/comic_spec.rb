# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comic, type: :model do
  subject { described_class.new(attributes) }

  let(:attributes) { attributes_for(:comic) }

  it { is_expected.to be_an_instance_of(described_class) }
end
