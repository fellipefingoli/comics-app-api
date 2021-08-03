# frozen_string_literal: true

module Marvel
  module Serializer
    class Comic
      class << self
        def call(data)
          data.map do |comic|
            ::Comic.new({
                          id: comic['id'],
                          title: comic['title'],
                          description: comic['description'],
                          price: parse_price(comic['prices']),
                          thumbnail: parse_thumbnail(comic['thumbnail']),
                          date: parse_date(comic['dates'])
                        })
          end
        end

        private

        def parse_price(prices)
          prices.select { |price| price['type'] == 'printPrice' }.first['price']
        end

        def parse_thumbnail(thumbnail)
          "#{thumbnail['path']}.#{thumbnail['extension']}"
        end

        def parse_date(dates)
          Time.zone.parse(dates.select { |date| date['type'] == 'onsaleDate' }.first['date'])
        end
      end
    end
  end
end
