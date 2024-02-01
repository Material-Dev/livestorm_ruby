# frozen_string_literal: true
require_relative "../test_helper"

class LivestormApiDeleteEventSessionTest < ActiveSupport::TestCase
  setup do
    stub_request(:delete, "#{LivestormApi::ROOT_URL}/sessions/some-id").to_return(status: 204, body: '{}')
  end

  should "return successful response" do
    result = LivestormApi.new(api_token: 'foo').delete_event_session('some-id')

    assert_equal(204, result.code)
  end
end
