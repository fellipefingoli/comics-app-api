# frozen_string_literal: true

class ComicsController < ApplicationController
  def index
    @comics = Marvel::Repository::Comic.get(query_params)
    render :index, status: :ok
  rescue StandardError => e
    @error = { code: 500, message: e.message }
    render :index, status: :internal_server_error
  end

  private

  def query_params
    params.permit(:format, :limit, :offset, :orderBy)
  end
end
