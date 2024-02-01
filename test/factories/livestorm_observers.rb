# frozen_string_literal: true

FactoryBot.define do
  factory :livestorm_observer_response, class: Array do
    skip_create
    sequence(:id) { |n| "observer-id-#{n}" }
    type { 'people' }
    attributes {
      {
        role: 'participant',
        first_name: 'Bob',
        last_name: 'Marley',
        registrant_detail: {
          password_key: '66ca049598265dcb3c311c',
          connection_link: 'https://app.livestorm.co/foo',
          is_guest_speaker: true,

        }
      }
    }

    initialize_with { { 'data' => [attributes.deep_stringify_keys] } }

    trait :not_guest_speaker do
      attributes {
        {
          registrant_detail: {
            is_guest_speaker: false
          }
        }
      }
    end
  end
end
