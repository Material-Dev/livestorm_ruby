# frozen_string_literal: true

require_relative "../test_helper"

class LivestormApiPostRegisterParticipantTest <ActiveSupport::TestCase
  setup do
    video_chat_session = FactoryBot.create(:video_chat_session, provider_id: 'foo')
    @participant_attrs = {
      session_id: video_chat_session.provider_id,
      type: 'people',
      attributes: {
        fields: [
          { id: 'email', value: 'foo@foo.com' },
          { id: 'first_name', value: 'Participant' },
          { id: 'last_name', value: 'Account' }
        ]
      }
    }
    @response = FactoryBot.create(:livestorm_participant).to_json
    stub_request(:post, "#{LivestormApi.root_url}/sessions/#{video_chat_session.provider_id}/people").to_return(status: 200, body: @response)
  end

  should 'return successful response' do
    result = LivestormApi.new(api_token: 'foo').post_register_participant(@participant_attrs)

    assert_equal(200, result.code)
    assert_equal(@response, result.body)
  end
end
