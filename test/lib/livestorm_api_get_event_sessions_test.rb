# frozen_string_literal: true

require_relative "../test_helper"


class LivestormApiGetEventSessionsTest < ActiveSupport::TestCase
  setup do
    @response = FactoryBot.create(:livestorm_sessions_response).to_json
    @livestorm_event_id = 'some-id'
    stub_request(:get, "#{LivestormApi.root_url}/events/#{@livestorm_event_id}/sessions").to_return(status: 200, body: @response)
  end

  should "return successful response" do
    result = LivestormApi.new(api_token: 'foo').get_event_sessions(@livestorm_event_id)

    assert_equal(200, result.code)
    assert_equal(@response, result.body)
  end
end
