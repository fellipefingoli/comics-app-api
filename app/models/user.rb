# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :user_marvel_comics

  validates :email, presence: true, uniqueness: true
end
