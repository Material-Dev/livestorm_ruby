# frozen_string_literal: true

require_relative "../test_helper"


class LivestormApiPostEventSessionsTest < ActiveSupport::TestCase
  setup do
    @response = FactoryBot.create(:livestorm_sessions_response).to_json
    @session_params = {
      type: 'sessions',
      livestorm_event_id: 'livestorm-event-id',
      attributes: {
        estimated_started_at: '2022-11-28 10:30:00',
        timezone: 'America/New_York'
      }
    }
    stub_request(:post, "#{LivestormApi::ROOT_URL}/events/livestorm-event-id/sessions").to_return(status: 200, body: @response)
  end

  should 'return successful response' do
    result = LivestormApi.new(api_token: 'foo').post_event_session(@session_params)

    assert_equal(200, result.code)
    assert_equal(@response, result.body)
  end
end
