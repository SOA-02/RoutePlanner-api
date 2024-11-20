# frozen_string_literal: true

require 'dry/monads'

module RoutePlanner
  module Service
    # logic of fetching viewed resources
    class AddOnlineResource
      include Dry::Monads::Result::Mixin
      MSG_SERVER_ERROR = 'AAA'

      def call(key_word)
        online_resources = Youtube::VideoRecommendMapper.new(App.config.API_KEY).find(key_word)
        online_resources.each do |entity|
          result = Repository::For.klass(RoutePlanner::Entity::Online).find_original_id(entity.original_id)

          if result.nil?
            Repository::For.entity(entity).build_online_resource(entity)
            puts '已儲存完畢'
          else
            puts '已有'
          end
        end
        Success(online_resources)
      rescue StandardError
        Failure(MSG_SERVER_ERROR)
        puts 'Could not access database'
      end

      def online_resource_from_youtube(input)
        Youtube::VideoMapper.new(App.config.API_KEY).find(input)
      rescue StandardError => e
        LOGGER.error("Error in online_resource_from_youtube: Could not find that video on Youtube - #{e.message}")
        Failure(MSG_ONLINE_NOT_FOUND)
      end
    end
  end
end
