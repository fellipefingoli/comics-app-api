# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Marvel::ComicLiked, type: :decorator do
  subject(:comic_liked) { described_class.new(comic, user) }

  let(:comic) { build(:comic) }
  let(:user) { create(:user) }

  it { is_expected.to be_an_instance_of(described_class) }

  it 'is liked' do
    expect(comic_liked.liked).to be_falsy
  end

  it 'is marvel type' do
    expect(comic_liked.type).to eq(:marvel)
  end
end
