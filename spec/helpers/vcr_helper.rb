# frozen_string_literal: true

require 'vcr'
require 'webmock'

# Setting up VCR
module VcrHelper
  CASSETTES_FOLDER = 'spec/fixtures/cassettes'
  YOUTUBE_CASSETTE = 'youtube_api'
  NTHUSA_CASSETTE = 'nthusa_api'

  def self.setup_vcr
    VCR.configure do |c|
      c.cassette_library_dir = CASSETTES_FOLDER
      c.hook_into :webmock
    end
  end

  def self.configure_vcr_for_youtube
    VCR.configure do |c|
      c.filter_sensitive_data('<API_KEY>') { API_KEY }
      c.filter_sensitive_data('<API_KEY_ESC>') { CGI.escape(API_KEY) }
    end

    VCR.insert_cassette(
      YOUTUBE_CASSETTE,
      record: :new_episodes,
      match_requests_on: %i[method uri headers]
    )
  end

  def self.configure_vcr_for_nthusa
    VCR.insert_cassette(
      NTHUSA_CASSETTE,
      record: :new_episodes,
      match_requests_on: %i[method uri headers]
    )
  end

  def self.eject_vcr
    VCR.eject_cassette
  end
end
