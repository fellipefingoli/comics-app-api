# frozen_string_literal: true

module Marvel
  class Connection
    def self.request
      RestClient::Resource.new(
        ENV['MARVEL_DEFAULT_URL']
      )
    end
  end
end
