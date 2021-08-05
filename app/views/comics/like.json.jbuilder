# frozen_string_literal: true

if @user_marvel_comic.present?
  json.comic do
    json.id @user_marvel_comic.comic_id
    json.liked @user_marvel_comic.liked
  end
end

if @error
  json.error do
    json.code @error[:code]
    json.message @error[:message]
  end
end
