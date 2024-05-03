# frozen_string_literal: true

require_relative "../test_helper"

class LivestormApiPatchEventSessionTest < ActiveSupport::TestCase
  setup do
    video_chat_session = FactoryBot.create(:video_chat_session, provider_id: 'provider-id')
    @response = FactoryBot.create(:livestorm_session_response).to_json
    @payload = FactoryBot.create(:video_chat_session_payload, video_chat_session: video_chat_session)
    stub_request(:patch, "#{LivestormApi.root_url}/sessions/#{video_chat_session.provider_id}").to_return(status: 200, body: @response)
  end

  should 'return successful response' do
    result = LivestormApi.new(api_token: 'foo').patch_event_session(@payload)
    assert_equal(200, result.code)
    assert_equal(@response, result.body)
  end
end
