# frozen_string_literal: true

FactoryBot.define do
  factory :livestorm_users_response, class: Hash do
    skip_create
    sequence(:id) { |n| "user-id-#{n}" }
    type { "users" }
    attributes do
      {
        "role" => "host",
        "created_at" => 1616453004,
        "updated_at" => 1634228904,
        "first_name" => "foo_first_name",
        "last_name" => "Foo_last_name",
        "email" => "foo@foo.com",
        "avatar_link" => nil,
        "locale" => "en",
        "pending_invite" => false,
        "website_link" => nil,
        "linkedin_link" => nil,
        "facebook_link" => nil,
        "twitter_handle" => nil
      }
    end

    initialize_with { { "data" => [attributes.deep_stringify_keys] } }
  end
end
