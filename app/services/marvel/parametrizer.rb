# frozen_string_literal: true

require 'digest'

module Marvel
  module Parametrizer
    def build_query_params(resource, params)
      "#{resource}?#{params.to_query}&#{auth_params.to_query}"
    end

    private

    def auth_params
      timestamp = Time.zone.now.to_i

      {
        ts: timestamp,
        apikey: ENV['MARVEL_PUBLIC_KEY'],
        hash: Digest::MD5.hexdigest(
          timestamp.to_s + ENV['MARVEL_PRIVATE_KEY'] + ENV['MARVEL_PUBLIC_KEY']
        )
      }
    end
  end
end
