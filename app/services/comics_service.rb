# frozen_string_literal: true

class ComicsService
  def self.fetch_marvel_comics(query_params, user)
    comics = Marvel::Repository::Comic.get(query_params)
    comics.map { |comic| Marvel::ComicLiked.new(comic, user) }
  end

  def self.fetch_character_comics(query_params, user)
    characters = Marvel::Repository::Character.get({ nameStartsWith: query_params.delete(:nameStartsWith) })
    comics = Marvel::Repository::Comic.get(query_params.merge({ characters: characters.pluck(:id).join(',')}))
    comics.map{ |comic| Marvel::ComicLiked.new(comic, user) }
  end
end
