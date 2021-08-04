# frozen_string_literal: true

FactoryBot.define do
  factory :user_marvel_comic do
    user { create(:user) }
    comic_id { 1 }
    liked { false }
  end
end
