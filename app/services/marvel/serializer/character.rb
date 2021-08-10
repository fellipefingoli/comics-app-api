# frozen_string_literal: true

module Marvel
  module Serializer
    class Character
      class << self
        def call(data)
          data.map do |character|
            {
              id: character['id'],
              name: character['name']
            }
          end
        end
      end
    end
  end
end
