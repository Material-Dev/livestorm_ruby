# frozen_string_literal: true

require_relative "../test_helper"


class LivestormApiGetEventPersonTest < ActiveSupport::TestCase
  setup do
    @response = FactoryBot.create(:livestorm_people_response).to_json
    @livestorm_event_id = 'some-id'
    @livestorm_person_id = 'some-person-id'
    stub_request(:get, "#{LivestormApi.root_url}/events/#{@livestorm_event_id}/people/#{@livestorm_person_id}").to_return(status: 200, body: @response)
  end

  should "return successful response" do
    result = LivestormApi.new(api_token: 'foo').get_event_person(livestorm_event_id: @livestorm_event_id, livestorm_person_id: @livestorm_person_id)

    assert_equal(200, result.code)
    assert_equal(@response, result.body)
  end
end
