# frozen_string_literal: true

require_relative "../test_helper"


# See: https://developers.livestorm.co/reference/post_events
#
class LivestormApiPostEventTest < ActiveSupport::TestCase
  setup do
    @event_attrs = {
      "type" => "events",
      "attributes" => {
        "owner_id" => "886e301e-258b-4986-a392-dd8b013f5d36",
        "title" => "New event",
        "slug" => "my-awesome-slug"
      },
      "relationships" => {
            "sessions" => [
                {
                      "attributes" => {
                          "estimated_started_at" => "2022-01-01",
                          "timezone" => "America/Los_Angeles"
                      }
                }
            ]
      }
    }
    @response = FactoryBot.create(:livestorm_events_response).to_json
    stub_request(:post, "#{LivestormApi.root_url}/events").to_return(status: 200, body: @response)
  end

  should "return successful response" do
    result = LivestormApi.new(api_token: 'foo').post_event(@event_attrs)
    assert_equal(200, result.code)
  end
end
