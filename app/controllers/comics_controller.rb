# frozen_string_literal: true

class ComicsController < ApplicationController
  before_action :find_user, only: [:index]

  def index
    @comics_liked = ComicsService.fetch(query_params, @user)
    render :index, status: :ok
  rescue StandardError => e
    @error = { code: 500, message: e.message }
    render :index, status: :internal_server_error
  end

  private

  def query_params
    params.permit(:format, :limit, :offset, :orderBy)
  end

  def find_user
    @user = User.find_by(session[:user_id])
  end
end
