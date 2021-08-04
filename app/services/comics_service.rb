# frozen_string_literal: true

class ComicsService
  def self.fetch(query_params, user)
    fetch_marvel_comics(query_params, user)
  end

  def self.fetch_marvel_comics(query_params, user)
    comics = Marvel::Repository::Comic.get(query_params)
    comics.map { |comic| Marvel::ComicLiked.new(comic, user) }
  end
end
