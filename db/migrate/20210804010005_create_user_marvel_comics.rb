# frozen_string_literal: true

class CreateUserMarvelComics < ActiveRecord::Migration[6.1]
  def change
    create_table :user_marvel_comics do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :comic_id, null: false, index: true
      t.boolean :liked, null: false, default: false

      t.timestamps
    end
  end
end
