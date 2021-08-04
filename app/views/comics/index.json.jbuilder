# frozen_string_literal: true

if @comics.present?
  json.comics @comics
elsif @error
  json.error do
    json.code @error[:code]
    json.message @error[:message]
  end
end

