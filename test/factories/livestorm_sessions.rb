# frozen_string_literal: true

FactoryBot.define do
  factory :livestorm_session_response, class: Hash do
    skip_create
    sequence(:id) { |n| "session-id-#{n}" }
    type { 'sessions' }
    attributes do
      {
        'event_id' => '35a8816a-3f6a-445f-867c-419ab2317586',
        'status' => 'past_not_started',
        'timezone' => 'America/Los_Angeles',
        'room_link' => 'https://app.livestorm.co/p/35a8816a-3f6a-445f-867c-419ab2317586/live?s=49488079-18d0-4ecb-b4ee-df11a25dd37f',
        'attendees_count' => 0,
        'duration' => nil,
        'estimated_started_at' => 1616176800,
        'started_at' => 0,
        'ended_at' => 0,
        'canceled_at' => 0,
        'created_at' => 1616173818,
        'updated_at' => 1617125626,
        'registrants_count' => 1
      }
    end

    initialize_with { { 'data' => attributes.deep_stringify_keys } }
  end

  factory :livestorm_sessions_response, parent: :livestorm_session_response do
    initialize_with { { 'data' => [attributes.deep_stringify_keys] } }
  end
end
