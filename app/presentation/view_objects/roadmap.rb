# frozen_string_literal: true

module Views
  # View for a single roadmap entity
  class Roadmap
    def initialize(roadmap, index = nil)
      @roadmap = roadmap
      @index = index
    end

    def entity
      @roadmap
    end

    def praise_link
      "/RoutePlanner/#{@roadmap.original_id}"
    end

    def index_str
      "roadmap[#{@index}]"
    end

    def original_id
      @roadmap.original_id
    end

    def topic
      @roadmap.topic
    end

    def url
      @roadmap.url
    end

    def platform
      @roadmap.platform
    end
  end
end
