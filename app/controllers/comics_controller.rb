# frozen_string_literal: true

class ComicsController < ApplicationController
  include Authorizable

  before_action :authorize, only: [:like]
  before_action :find_user_marvel_comic, only: [:like]

  def index
    @comics_liked = ComicsService.fetch_marvel_comics(query_params, @user)
    render :index, status: :ok
  rescue StandardError => e
    @error = { code: 500, message: e.message }
    render :index, status: :internal_server_error
  end

  def like
    @user_marvel_comic.update!({ liked: params[:liked] })
    render :like, status: :ok
  rescue StandardError => e
    @error = { code: 500, message: e.message }
    render :like, status: :internal_server_error
  end

  def character_comics
    @comics_liked = ComicsService.fetch_character_comics(query_params, @user)
    render :character_comics, status: :ok
  rescue StandardError => e
    @error = { code: 500, message: e.message }
    render :index, status: :internal_server_error
  end

  private

  def query_params
    params.permit(:format, :limit, :offset, :orderBy, :nameStartsWith)
  end

  def find_user_marvel_comic
    @user_marvel_comic = UserMarvelComic.find_or_create_by({ user: @user, comic_id: params[:id] })
  end
end
