# frozen_string_literal: true

FactoryBot.define do
  factory :comic do
    title { Faker::Superhero.name }
    description { Faker::Superhero.power }
    price { 2.99 }
    thumbnail { 'http://comics.com/someimagehere.jpg' }
    date { Time.zone.today }
  end
end
