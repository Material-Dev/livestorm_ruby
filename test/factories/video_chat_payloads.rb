# frozen_string_literal: true

FactoryBot.define do
  factory :video_chat_payload, class: Hash do
    skip_create
    id { video_chat.provider_id }
    type { "events" }
    attributes do
      {
        owner_id: video_chat_settings["livestorm_owner_id"],
        copy_from_event_id: video_chat_settings["livestorm_template_id"],
        title: video_chat.name,
        slug: "#{video_chat.company_subdomain}-#{video_chat.name}".gsub(/\s/, '-'),
        registration_page_enabled: false,
        status: 'published'
      }
    end
    
    initialize_with { attributes.except(:video_chat, :video_chat_settings) }
  end
end

