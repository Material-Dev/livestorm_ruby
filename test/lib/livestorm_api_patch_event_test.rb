# frozen_string_literal: true

require_relative "../test_helper"

class LivestormApiPatchEventTest < ActiveSupport::TestCase
  setup do
    video_chat = FactoryBot.create(:video_chat, provider_id: 'provider-id')
    @response = FactoryBot.create(:livestorm_event_response).to_json
    @payload = FactoryBot.create(:video_chat_payload, video_chat: video_chat, video_chat_settings: {})
    stub_request(:patch, "#{LivestormApi::ROOT_URL}/events/#{video_chat.provider_id}").to_return(status: 200, body: @response)
  end

  should 'return successful response' do
    result = LivestormApi.new(api_token: 'foo').patch_event(@payload)
    assert_equal(200, result.code)
    assert_equal(@response, result.body)
  end
end
