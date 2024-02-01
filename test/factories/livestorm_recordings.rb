# frozen_string_literal: true

FactoryBot.define do
  factory :livestorm_recordings_response, class: Hash do
    skip_create
    sequence(:id) { |n| "id-#{n}" }
    type { 'recordings' }
    attributes do
      {
        "event_id": "38b9a37f-2376-42df-9871-1dd55b42acfc",
        "session_id": "944103b5-a2ad-45a1-845b-906e3f196561",
        "file_type": "video",
        "mime_type": "mp4",
        "file_size": 27327779,
        "file_name": "59f9df74-d40a-4ed0-b1fd-09c184a1a3cf.mp4",
        "url": "foo://bar.com/59f9df74-d40a-4ed0-b1fd-09c184a1a3cf.mp4&=secret_key",
        "url_generated_at": 1690835598,
        "url_expires_in": 43200
      }
    end

    initialize_with { { "data" => [attributes.deep_stringify_keys] } }
  end
end
