# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Marvel::Serializer::Comic, type: :service do
  describe '.call' do
    subject(:data_serialized) { described_class.call(comic_data).first }

    let(:comic_data) { JSON.parse(file_fixture('marvel_comics_data.json').read) }

    it { is_expected.to be_an_instance_of(Comic) }

    it 'serialize marvel comics data to comic model' do
      expect(data_serialized.id).to eq(183)
      expect(data_serialized.title).to eq('Startling Stories: The Incorrigible Hulk (2004) #1')
      expect(data_serialized.price).to eq(2.99)
      expect(data_serialized.thumbnail).to eq('http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg')
      expect(data_serialized.date).to eq(Time.zone.parse('2029-12-31T00:00:00-0500'))
    end
  end
end
