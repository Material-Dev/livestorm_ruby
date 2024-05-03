# frozen_string_literal: true

require_relative "../test_helper"

class LivestormApiGetUsersTest < ActiveSupport::TestCase
  setup do
    @response = FactoryBot.create(:livestorm_users_response).to_json
    stub_request(:get, "#{LivestormApi.root_url}/users").to_return(status: 200, body: @response)
  end

  should "return successful response" do
    result = LivestormApi.new(api_token: 'foo').get_users

    assert_equal(200, result.code)
    assert_equal(@response, result.body)
  end

  context 'when filter option is passed' do
    setup do
      stub_request(:get, "#{LivestormApi.root_url}/users?filter[role]=host").to_return(status: 200, body: @response)
    end

    should "return successful response" do
      result = LivestormApi.new(api_token: 'foo').get_users({'filter[role]' => 'host'})

      assert_equal(200, result.code)
      assert_equal(@response, result.body)
    end
  end
end
