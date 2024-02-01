# frozen_string_literal: true

require_relative "../test_helper"


class LivestormApiGetUsersTest < ActiveSupport::TestCase
  setup do
    @response = FactoryBot.create(:livestorm_recordings_response).to_json
    @session_id = 'abc'
    stub_request(:get, "#{LivestormApi::ROOT_URL}/sessions/#{@session_id}/recordings").to_return(status: 200, body: @response)
  end

  should "return successful response" do
    result = LivestormApi.new(api_token: 'foo').get_recordings(@session_id)

    assert_equal(200, result.code)
    assert_equal(@response, result.body)
  end
end
