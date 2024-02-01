# frozen_string_literal: true

FactoryBot.define do
  factory :video_chat, class: OpenStruct do
    sequence(:name) { |n| "Clark Kent#{n}" }
    time_zone { 'America/Los_Angeles' }
    reminder_time_in_minutes { 20 }
    about_to_start_time_in_minutes { 30 }
    communication_email  {'coms'}
    unsubscribe_email {'unsub'}
    company_subdomain {'comp_subdomain'}
  end
end
