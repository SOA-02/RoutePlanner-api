# frozen_string_literal: true

module RoutePlanner
  module Repository
    # Repository for Videos
    class Physicals
      def self.all
        Database::PhysicalOrm.all.map { |db_resource| rebuild_entity(db_resource) }
      end

      def self.find_all_course(course_ids)
        course_ids.map do |course_id|
          find_id(course_id)
        end.compact
      end

      def self.find_id(course_id)
        db_resource = Database::PhysicalOrm.first(course_id:)
        rebuild_entity(db_resource)
      end

      def self.create(entity)
        return if find(entity)

        db_resource = Database::PhysicalOrm.create(entity.to_attr_hash)
        rebuild_entity(db_resource)
      end

      def self.rebuild_entity(db_resource)
        return nil unless db_resource

        Entity::Physical.new(
          id: db_resource.id,
          course_id: db_resource.course_id,
          course_name: db_resource.course_name,
          credit: db_resource.credit,
          language: db_resource.language,
          provider: db_resource.provider,
          timeloc: db_resource.timeloc
        )
      end

      def initialize(entity)
        @entity = entity
      end
    end
  end
end