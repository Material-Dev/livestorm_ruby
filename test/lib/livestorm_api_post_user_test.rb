# frozen_string_literal: true

require_relative "../test_helper"


class LivestormApiPostUsertest < ActiveSupport::TestCase
  setup do
    @user_attrs = {
      "type" => "users",
      "attributes" => {
        "email" => "foo@foo.com",
        "role" => "moderator"
      }
    }
    @response = FactoryBot.create(:livestorm_users_response).to_json
    stub_request(:post, "#{LivestormApi::ROOT_URL}/users").to_return(status: 200, body: @response)
  end

  should "return successful response" do
    result = LivestormApi.new(api_token: 'foo').post_user(@user_attrs)
    assert_equal(200, result.code)
  end
end
