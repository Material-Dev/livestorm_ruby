# frozen_string_literal: true

FactoryBot.define do
  factory :livestorm_participant, class: Hash do
    skip_create
    sequence(:id) { |n| "participant-id-#{n}" }
    type { 'people' }
    attributes do
      {
        role: 'participant',
        registrant_detail: {
          password_key: '66ca049598265dcb3c311c',
          connection_link: 'https://app.livestorm.co/foo'
        }
      }
    end

    initialize_with { { 'data' => attributes.deep_stringify_keys } }
  end
end

=begin Example Full Response
{"data"=>
  {"id"=>"cafe55a9-dfb1-4ee3-8c23-5a5dfac08178",
   "type"=>"people",
   "attributes"=>
    {"role"=>"participant",
     "created_at"=>1631989406,
     "updated_at"=>1631989406,
     "timezone"=>nil,
     "first_name"=>"Manual",
     "last_name"=>"Tester",
     "email"=>"foo@foo.com",
     "avatar_link"=>nil,
     "registrant_detail"=>
      {"event_id"=>"56bc42f3-c961-4e57-bb34-884503ec84d2",
       "session_id"=>"7c83be2a-4c81-464c-8a54-013eaa08243c",
       "created_at"=>1631989406,
       "updated_at"=>1631989406,
       "fields"=>
        [{"id"=>"email", "type"=>"text", "value"=>"foo@foo.com", "required"=>true},
         {"id"=>"first_name", "type"=>"text", "value"=>"Manual", "required"=>true},
         {"id"=>"last_name", "type"=>"text", "value"=>"Tester", "required"=>true},
         {"id"=>"avatar", "type"=>"file", "value"=>nil, "required"=>false}],
       "referrer"=>nil,
       "utm_source"=>nil,
       "utm_medium"=>nil,
       "utm_term"=>nil,
       "utm_content"=>nil,
       "utm_campaign"=>nil,
       "browser_version"=>nil,
       "browser_name"=>nil,
       "os_name"=>nil,
       "os_version"=>nil,
       "screen_height"=>nil,
       "screen_width"=>nil,
       "ip_city"=>nil,
       "ip_country_code"=>nil,
       "ip_country_name"=>nil,
       "password_key"=>"66ca049598265dcb3c311c",
       "connection_link"=>
        "https://app.livestorm.co/p/56bc42f3-c961-4e57-bb34-884503ec84d2/live?email=foo%40foo.com&key=66ca049598265dcb3c311c&s=7c83be2a-4c81-464c-8a54-013eaa08243c",
       "attended"=>false,
       "attendance_rate"=>nil,
       "attendance_duration"=>0,
       "is_highlighted"=>false,
       "is_guest_speaker"=>false},
     "messages_count"=>0,
     "questions_count"=>0,
     "votes_count"=>0,
     "up_votes_count"=>0}}}
=end
