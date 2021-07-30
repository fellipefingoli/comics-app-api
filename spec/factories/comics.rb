FactoryBot.define do
  factory :comic do
    title { Faker::Superhero.name }
    description { Faker::Superhero.power }
    price { 2.99 }
    thumbnail { 'http://comics.com/someimagehere.jpg' }
    image { 'http://comics.com/someimagehere.jpg' }
    date { Date.new }
  end
end
