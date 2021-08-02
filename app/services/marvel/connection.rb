# frozen_string_literal: true

module Marvel
  class Connection
    def self.request(resource_name)
      RestClient::Resource.new(
        ENV['MARVEL_DEFAULT_URL']
      )[resource_name]
    end
  end
end
