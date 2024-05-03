# frozen_string_literal: true

require_relative "../test_helper"


class LivestormApiGetEventsTest < ActiveSupport::TestCase
  setup do
    @response = FactoryBot.create(:livestorm_events_response).to_json
  end

  context "without params" do
    setup do
      stub_request(:get, "#{LivestormApi.root_url}/events").to_return(status: 200, body: @response)
    end

    should "return successful response" do
      result = LivestormApi.new(api_token: 'foo').get_events

      assert_equal(200, result.code)
      assert_equal(@response, result.body)
    end
  end

  context "when specifying a param" do
    # Since the stub_request will only match if the param is set correctly,
    # this test basically checks that we are passing our param into RestClient::Request
    # correctly.  Otherwise the unmatched request would raise because we have configured
    # test suite to not allow real requests.
    # This test does not/can not check the effect of the param.
    #
    setup do
      @query_params = {"page[number]" => 1}
      stub_request(:get, "#{LivestormApi.root_url}/events").with(query: @query_params).to_return(status: 200)
    end

    should "return successful response" do
      result = LivestormApi.new(api_token: 'foo').get_events(@query_params)

      assert_equal(200, result.code)
    end
  end
end
