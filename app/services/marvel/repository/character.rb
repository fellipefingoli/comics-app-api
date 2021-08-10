# frozen_string_literal: true

module Marvel
  module Repository
    class Character
      extend Parametrizer

      def self.get(params = {})
        query_params = build_query_params('characters', params)
        response = Connection.request[query_params].get
        Marvel::Serializer::Character.call(JSON.parse(response.body)['data']['results'])
      end
    end
  end
end
