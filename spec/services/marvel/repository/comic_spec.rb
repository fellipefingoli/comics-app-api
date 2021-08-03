# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Marvel::Repository::Comic, type: :service do
  describe '.get' do
    subject(:response) do
      VCR.use_cassette('get_marvel_comics', record: :all) do
        described_class.get(params)
      end
    end

    let(:params) { { format: 'comic', limit: 1, orderBy: '-onsaleDate' } }
    let(:comic_data) { JSON.parse(file_fixture('marvel_comics_data.json').read) }
    let(:comic) { build(:comic) }

    before do
      allow(Marvel::Serializer::Comic).to receive(:call)
        .with(comic_data)
        .and_return([comic])
    end

    it 'returns an array of serialized Comic model data' do
      expect(response).to be_an_instance_of(Array)
      expect(response.first).to be_an_instance_of(Comic)
    end
  end
end
