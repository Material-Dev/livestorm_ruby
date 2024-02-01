# frozen_string_literal: true

require_relative "../test_helper"


class LivestormApiGetEventTest < ActiveSupport::TestCase
  setup do
    @response = FactoryBot.create(:livestorm_events_response).to_json
  end

  context "without params" do
    setup do
      @livestorm_event_id = 'some-id'
      stub_request(:get, "#{LivestormApi::ROOT_URL}/events/#{@livestorm_event_id}").to_return(status: 200, body: @response)
    end

    should "return successful response" do
      result = LivestormApi.new(api_token: 'foo').get_event(@livestorm_event_id)

      assert_equal(200, result.code)
    end
  end
end
