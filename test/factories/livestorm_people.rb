# frozen_string_literal: true

FactoryBot.define do
  factory :livestorm_people_response, class: Hash do
    skip_create
    sequence(:id) { |n| "person-id-#{n}" }
    type { "people" }
    attributes do
      {
        "role"=>"team_member",
        "created_at"=>1616098251,
        "updated_at"=>1629059194,
        "timezone"=>"America/Los_Angeles",
        "first_name"=>"Stephen",
        "last_name"=>"Philp",
        "email"=>"sphilp@soapboxsample.com",
        "avatar_link"=>nil,
        "registrant_detail"=>
          {
            "event_id"=>"374d0ddb-5a47-4504-9fa3-1d70ab7fa5f7",
            "created_at"=>1629059133,
            "updated_at"=>1629059194,
            "fields"=> [
              { "id"=>"email", "type"=>"text", "value"=>nil, "required"=>true },
              { "id"=>"first_name", "type"=>"text", "value"=>nil, "required"=>true },
              { "id"=>"last_name", "type"=>"text", "value"=>nil, "required"=>true },
              { "id"=>"avatar", "type"=>"file", "value"=>nil, "required"=>false }
            ]
          }
      }
    end

    initialize_with { { "data" => [attributes.deep_stringify_keys] } }
  end
end
