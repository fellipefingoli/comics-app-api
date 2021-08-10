# frozen_string_literal: true

if @comics_liked.present?
  json.comics do
    json.array! @comics_liked do |comic_liked|
      json.id comic_liked.comic.id
      json.title comic_liked.comic.title
      json.description comic_liked.comic.description
      json.price comic_liked.comic.price
      json.thumbnail comic_liked.comic.thumbnail
      json.date comic_liked.comic.date
      json.liked comic_liked.liked
      json.type comic_liked.type
    end
  end
elsif @error
  json.error do
    json.code @error[:code]
    json.message @error[:message]
  end
end
