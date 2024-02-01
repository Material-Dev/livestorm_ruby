require 'active_support/core_ext/numeric/time'
FactoryBot.define do
  factory :video_chat_session, class: OpenStruct  do
    provider_id {provider_id}
    duration_in_minutes { 10 }
    start_date { 1.day.from_now.strftime('%Y-%m-%d') }
    start_time { '13:52' }
    time_zone { 'America/Los_Angeles' }
    host { 'John Oliver' }
  end
end