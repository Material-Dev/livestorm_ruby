# frozen_string_literal: true
require_relative "../test_helper"

class LivestormApiGetPingTest < ActiveSupport::TestCase
  setup do
    stub_request(:get, "#{LivestormApi::ROOT_URL}/ping").to_return(status: 200, body: "{}")
  end

  should "return successful response" do
    result = LivestormApi.new(api_token: 'foo').get_ping

    assert_equal(200, result.code)
    assert_equal("{}", result.body)
  end

  context "when we have less than 1000 remaining requests" do
    setup do
      return_headers = {"ratelimit_monthly_remaining" => 999, "ratelimit_monthly_limit" => 5000}
      stub_request(:get, "#{LivestormApi::ROOT_URL}/ping").to_return(status: 200, body: "{}", headers: return_headers)
    end

    should "log warning" do
      mock_logger = Minitest::Mock.new
      mock_logger.expect(:warn, nil, ['Livestorm periodic limit nearly reached!'])
      Logger.stub(:new, mock_logger) do
        LivestormApi.new(api_token: 'foo').get_ping
      end
  
      mock_logger.verify
    end
  end
end
