# frozen_string_literal: true

require_relative '../../helpers/spec_helper'
require_relative '../../helpers/vcr_helper'

describe 'Tests Youtube API library' do
  before do
    VcrHelper.configure_vcr_for_youtube
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Search information' do
    before do
      @relevant_result = RoutePlanner::Youtube::VideoRecommendMapper
        .new(API_KEY)
        .find(KEY_WORD)
    end

    it 'HAPPY: search relevant gateway captures search relevant results' do
      @search_relevant_data = RoutePlanner::Youtube::YoutubeApi.new(API_KEY).search_relevant(KEY_WORD)
      _(@search_relevant_data).must_be_kind_of Hash
      _(@search_relevant_data['items']).must_be_kind_of Array
    end

    it 'HAPPY: recognize search relevant results' do
      assert_kind_of Array, @relevant_result
      refute_empty @relevant_result
      @relevant_result.each do |item|
        assert_kind_of RoutePlanner::Entity::Online, item
      end
    end

    it 'HAPPY: should get  using try' do
      @relevant_result.each do |item|
        refute_nil item.topic
        refute_nil item.url
        refute_nil item.platform
      end
    end
    # describe 'Video Information' do
    #   before do
    #     @video_data = Outline::Youtube::YoutubeApi.new(API_KEY).video_info(VIDEO_ID)
    #     @items_data = @video_data['items'].first
    #     @video_mapper = Outline::Youtube::VideoMapper.new(API_KEY).find(VIDEO_ID)
    #   end

    #   it 'HAPPY: fetches video data successfully' do
    #     _(@video_data).must_be_kind_of Hash
    #     _(@video_data['kind']).must_equal 'youtube#videoListResponse'

    #     _(@items_data['kind']).must_equal 'youtube#video'
    #     _(@items_data['id']).must_equal VIDEO_ID
    #   end

    #   it 'HAPPY: maps video data successfully' do
    #     _(@video_mapper).must_be_kind_of Outline::Entity::Video
    #   end

    #   it 'HAPPY: entity are of correct type' do
    #     _(@video_mapper.video_id).must_equal VIDEO_ID
    #     _(@video_mapper.video_title).must_be_kind_of String
    #     _(@video_mapper.video_description).must_be_kind_of String
    #     _(@video_mapper.video_published_at).must_be_kind_of String
    #   end
    # end

    # describe 'HAPPY: Parse video description' do
    #   before do
    #     @video = Outline::Youtube::VideoMapper
    #       .new(API_KEY)
    #       .find(VIDEO_ID)
    #   end

    #   it 'HAPPY: should parse video description' do
    #     @toc = Views::Timestamp.new(@video.video_description).extract_toc
    #     binding.irb
    #     assert_kind_of Array, @toc
    #     @toc.each do |timestamp, title|
    #       assert_match(/\d{1,2}:\d{2}(?::\d{2})?/, timestamp) # Check timestamp format
    #       assert_kind_of String, title # Check title is a string
    #     end
    #   end
    # end
  end
end
