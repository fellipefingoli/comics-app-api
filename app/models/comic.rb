# frozen_string_literal: true

class Comic
  include ActiveModel::Model

  attr_accessor :id, :title, :description, :price, :thumbnail, :date
end
