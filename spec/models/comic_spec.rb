require 'rails_helper'

RSpec.describe Comic, type: :model do
  let(:attributes) { attributes_for(:comic) }

  subject { described_class.new(attributes) }

  it { is_expected.to be_an_instance_of(Comic) }
end
