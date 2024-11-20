# frozen_string_literal: true

require 'dry/transaction'
require 'logger'

module RoutePlanner
  module Service
    # Transaction to store rec_resource from Youtube API to database
    class AddPhysicalResource
      MSG_ONLINE_NOT_FOUND = 'Could not find any Online resource'
      MSG_ONLINEINFO_NOT_FOUND = 'Sorry, could not find that Online resource information.'
      include Dry::Transaction

      step :find_physical_resource
      step :store_physical_resource

      private

      # Logger instance for better error tracking
      LOGGER = Logger.new($stdout)
      def find_physical_resource(skill) # rubocop:disable Metrics/MethodLength
        online_resource_info = {}
        online_resource = online_resource_in_database(skill)
        if online_resource
          online_resource_info[:local_physical_resource] = online_resource
        else
          online_resource_info[:remote_physical_resource] = online_resource_from_youtube(skill)
        end
        Success(online_resource_info)
      rescue StandardError => e
        LOGGER.error("Error in find_physical_resource: #{e.message}")
        Failure(e.message)
      end

      def store_physical_resource(online_resource_info)
        online_resource_info[:remote_video]&.each do |entity|
          Repository::For.entity(entity).build_online_resource(entity)
          puts '已儲存完畢'
        end
        Success(online_resource_info)
      rescue StandardError => e
        LOGGER.error("Error in store_physical_resource: Having trouble accessing the database - #{e.message}")
        Failure(MSG_VIDINFO_NOT_FOUND)
      end

      # Support methods for fetching video data

      def online_resource_from_youtube(input)
        Youtube::VideoMapper.new(App.config.API_KEY).find(input)
      rescue StandardError => e
        LOGGER.error("Error in online_resource_from_youtube: Could not find that video on Youtube - #{e.message}")
        Failure(MSG_VID_NOT_FOUND)
      end

      def online_resource_in_database(input)
        Repository::For.klass(Entity::Online).find_all_resource_of_skills(input)
      end
    end
  end
end
