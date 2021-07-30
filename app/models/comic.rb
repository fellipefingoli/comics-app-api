class Comic
  include ActiveModel::Model

  attr_accessor :id, :title, :description, :price, :thumbnail, :image, :date
end
