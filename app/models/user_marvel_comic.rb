# frozen_string_literal: true

class UserMarvelComic < ApplicationRecord
  belongs_to :user

  def type
    :marvel
  end
end
