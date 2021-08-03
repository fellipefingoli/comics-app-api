# frozen_string_literal: true

module Marvel
  module Repository
    class Comic
      extend Parametrizer

      def self.get(params = { format: 'comic' })
        query_params = build_query_params('comics', params)
        response = Connection.request[query_params].get
        Marvel::Serializer::Comic.call(JSON.parse(response.body)['data']['results'])
      end
    end
  end
end
