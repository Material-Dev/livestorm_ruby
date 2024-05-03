# frozen_string_literal: true
require_relative "../test_helper"

class LivestormApiGetPingTest < ActiveSupport::TestCase
  setup do
    stub_request(:get, "#{LivestormApi.root_url}/ping").to_return(status: 200, body: "{}")
  end

  should "return successful response" do
    result = LivestormApi.new(api_token: 'foo').get_ping

    assert_equal(200, result.code)
    assert_equal("{}", result.body)
  end
end
