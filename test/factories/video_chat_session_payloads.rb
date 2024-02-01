# frozen_string_literal: true

FactoryBot.define do
  factory :video_chat_session_payload, class: Hash do
    skip_create
    id { video_chat_session.provider_id }
    type { "sessions" }
    attributes do
      {
        estimated_started_at: "#{video_chat_session.start_date} #{video_chat_session.start_time}",
        timezone: video_chat_session.time_zone
      }
    end
    
    initialize_with { attributes.except(:video_chat_session) }
  end
end

