# frozen_string_literal: true

FactoryBot.define do
  factory :livestorm_event_response, class: Hash do
    skip_create
    sequence(:id) { |n| "event-id-#{n}" }
    type { "events" }
    attributes do
      {
        title: "my title",
        slug: "my-title",
        registration_link: "https://my.registration/link",
        owner: {
          id: "owner-id",
          type: "people",
          attributes: {
            role: "team_member"
          }
        },
        sessions_count: 1
      }
    end

    relationships do
      {
        sessions: {
          data: [
            {
              type: 'sessions',
              id: 'session-id'
            }
          ]
        }
      }
    end

    initialize_with { { "data" => attributes.deep_stringify_keys } }
  end

  factory :livestorm_events_response, parent: :livestorm_event_response do
    initialize_with { { "data" => [attributes.deep_stringify_keys] } }
  end
end

=begin Example Full Response
{
  "data": {
    "id": "f898474a-b720-41b2-a813-8ba39db8b98a",
    "type": "events",
    "attributes": {
      "title": "New event",
      "slug": "my-awesome-slug",
      "registration_link": "https://app.livestorm.co/p/f898474a-b720-41b2-a813-8ba39db8b98a",
      "estimated_duration": 30,
      "registration_page_enabled": true,
      "everyone_can_speak": false,
      "description": "Fuga rerum ut. Quod quas facere. Est culpa harum.3",
      "status": "draft",
      "light_registration_page_enabled": true,
      "recording_enabled": true,
      "recording_public": null,
      "show_in_company_page": false,
      "chat_enabled": true,
      "polls_enabled": true,
      "questions_enabled": true,
      "language": "en",
      "published_at": 0,
      "created_at": 1631022340,
      "updated_at": 1631022340,
      "owner": {
        "id": "b50fbc30-fd46-47b4-aa70-8c83399420f3",
        "type": "people",
        "attributes": {
          "role": "team_member",
          "created_at": 1631022340,
          "updated_at": 1631022340,
          "timezone": "Europe/Paris",
          "first_name": "Park-6",
          "last_name": "Torvald-6",
          "email": "6-leann@blandastanton.org",
          "avatar_link": null
        }
      },
      "sessions_count": 1,
      "fields": [
        {
          "id": "email",
          "type": "text",
          "order": 0,
          "required": true
        },
        {
          "id": "first_name",
          "type": "text",
          "order": 1,
          "required": true
        },
        {
          "id": "last_name",
          "type": "text",
          "order": 2,
          "required": true
        },
        {
          "id": "avatar",
          "type": "file",
          "order": 3,
          "required": false
        },
        {
          "id": "input_text",
          "type": "text",
          "order": 4,
          "custom": true,
          "required": true
        },
        {
          "id": "select_radio",
          "type": "multiple",
          "order": 5,
          "custom": true,
          "options": {
            "items": [
              {
                "value": "Choice A"
              },
              {
                "value": "Choice B"
              },
              {
                "value": "Choice C"
              }
            ],
            "multiple_answers": false
          },
          "required": true
        },
        {
          "id": "select_checkbox",
          "type": "multiple",
          "order": 6,
          "custom": true,
          "options": {
            "items": [
              {
                "value": "Choice A"
              },
              {
                "value": "Choice B"
              },
              {
                "value": "Choice C"
              }
            ],
            "multiple_answers": true
          },
          "required": true
        }
      ]
    },
    "relationships": {
      "sessions": {
        "data": [
          {
            "type": "sessions",
            "id": "fff0671a-869e-463f-9140-358ad5d5f77d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fff0671a-869e-463f-9140-358ad5d5f77d",
      "type": "sessions",
      "attributes": {
        "event_id": "f898474a-b720-41b2-a813-8ba39db8b98a",
        "status": "draft",
        "timezone": "Europe/Paris",
        "room_link": "https://app.livestorm.co/p/f898474a-b720-41b2-a813-8ba39db8b98a/live?s=fff0671a-869e-463f-9140-358ad5d5f77d",
        "attendees_count": 0,
        "duration": null,
        "estimated_started_at": 1631108740,
        "started_at": 0,
        "ended_at": 0,
        "canceled_at": 0,
        "created_at": 1631022341,
        "updated_at": 1631022341,
        "registrants_count": 1
      }
    }
  ]
}
=end
