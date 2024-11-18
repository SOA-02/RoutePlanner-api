# frozen_string_literal: true

module RoutePlanner
  module Repository
    # Repository for Videos
    class Onlines
      def self.all
        Database::OnlineOrm.all.map { |db_resource| rebuild_entity(db_resource) }
      end

      def self.find(entity)
        find_url(entity.url)
      end

      def self.find_all_resource(urls)
        urls.map do |url|
          find_url(url)
        end.compact
      end

      def self.find_url(url)
        db_resource = Database::OnlineOrm.first(url:)
        rebuild_entity(db_resource)
      end

      def self.build_online_resource(entity)
        return if find(entity)

        db_resource = Database::OnlineOrm.create(entity.to_attr_hash)
        rebuild_entity(db_resource)
      end

      def self.rebuild_entity(db_resource)
        return nil unless db_resource

        Entity::Online.new(
          id: db_resource.id,
          original_id: db_resource.original_id,
          topic: db_resource.topic,
          url: db_resource.url,
          platform: db_resource.platform
        )
      end

      def initialize(entity)
        @entity = entity
      end
    end
  end
end
