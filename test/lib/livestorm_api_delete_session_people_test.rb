# frozen_string_literal: true

require_relative "../test_helper"

class LivestormApiDeleteSessionPeopleTest <ActiveSupport::TestCase
  setup do
    @response = FactoryBot.create(:livestorm_participant).to_json
    @some_id = 'abc'
    @email = 'some@bodyoncetold.me'
    stub_request(:delete, "#{LivestormApi.root_url}/sessions/#{@some_id}/people?filter[email]=#{@email}").to_return(status: 200, body: @response)
  end

  should 'return successful response' do
    result = LivestormApi.new(api_token: 'foo').delete_session_people(@some_id, @email)

    assert_equal(200, result.code)
    assert_equal(@response, result.body)
  end
end
