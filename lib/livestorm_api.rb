# frozen_string_literal: true
require 'rest-client'

class LivestormApi
  # This class provides access to the Livestorm RESTful endpoints
  # It returns a RestClient::Response and allows any RestClient Errors to bubble up
  # In addition to burst rate limits, Livestorm has periodic (monthly) limits.  Each
  # call should be wrapped with #notify_remaining_limits to alert us if limits
  # are running low.
  # See: https://developers.livestorm.co/docs/rate-limits-and-quotas
  #
  #
  def initialize(api_token:, root_url: 'https://api.livestorm.co/v1')
    @api_token = api_token
    @root_url = root_url
  end

  def get_ping
    RestClient.get("#{root_url}/ping", headers)
  end

  def get_events(options = {})
    params = { params: options }
    RestClient::Request.execute(method: :get, url: "#{root_url}/events", headers: headers.merge(params))
  end

  # requires an event Hash
  #
  def post_event(event)
    payload = { data: event }.to_json
    RestClient.post("#{root_url}/events", payload, headers)
  end

  # requires an event Hash
  #
  def patch_event(event)
    id = event.delete(:id)
    payload = { data: event }.to_json
    RestClient.patch("#{root_url}/events/#{id}", payload, headers)
  end

  def get_event(livestorm_event_id)
    RestClient.get("#{root_url}/events/#{livestorm_event_id}", headers)
  end

  def get_event_people(livestorm_event_id, options = {})
    params = { params: options }
    RestClient::Request.execute(
      method: :get,
      url: "#{root_url}/events/#{livestorm_event_id}/people",
      headers: headers.merge(params)
    )
  end

  def get_event_person(livestorm_event_id:, livestorm_person_id:)
    RestClient.get("#{root_url}/events/#{livestorm_event_id}/people/#{livestorm_person_id}", headers)
  end

  def get_event_sessions(livestorm_event_id, options = {})
    params = { params: options }
    RestClient::Request.execute(
      method: :get,
      url: "#{root_url}/events/#{livestorm_event_id}/sessions",
      headers: headers.merge(params)
    )
  end

  def post_event_session(session_attrs)
    livestorm_event_id = session_attrs.delete(:livestorm_event_id)
    payload = { data: session_attrs }.to_json
    RestClient.post("#{root_url}/events/#{livestorm_event_id}/sessions", payload, headers)
  end

  def patch_event_session(session_attrs)
    id = session_attrs.delete(:id)
    payload = { data: session_attrs }.to_json
    RestClient.patch("#{root_url}/sessions/#{id}", payload, headers)
  end

  def delete_event_session(livestorm_event_session_id)
    RestClient.delete("#{root_url}/sessions/#{livestorm_event_session_id}", headers)
  end

  def post_register_participant(participant_attrs)
    id = participant_attrs.delete(:session_id)

    payload = { data: participant_attrs }.to_json
    RestClient.post("#{root_url}/sessions/#{id}/people", payload, headers)
  end

  def get_session(livestorm_session_id)
    RestClient::Request.execute(
      method: :get,
      url: "#{root_url}/sessions/#{livestorm_session_id}",
      headers: headers
    )
  end

  def get_session_people(livestorm_session_id)
    RestClient::Request.execute(
      method: :get,
      url: "#{root_url}/sessions/#{livestorm_session_id}/people",
      headers: headers
    )
  end

  def delete_session_people(livestorm_session_id, email)
    RestClient::Request.execute(
      method: :delete,
      url: "#{root_url}/sessions/#{livestorm_session_id}/people?filter[email]=#{email}",
      headers: headers
    )
  end

  # options:
  # {"filter[role]" => "",
  #  "filter[pending_invite]" => "",
  #  "filter[email]" => ""}
  #
  def get_users(options = {})
    params = { params: options }
    RestClient.get("#{root_url}/users", headers.merge(params))
  end

  def post_user(user_attrs)
    payload = { data: user_attrs }.to_json

    RestClient.post("#{root_url}/users", payload, headers)
  end

  # mostly helpful for debugging
  #
  def get_current_user
    RestClient.get("#{root_url}/me", headers)
  end

  # mostly helpful for debugging
  #
  def get_people
    RestClient.get("#{root_url}/people", headers)
  end

  # mostly helpful for debugging
  #
  def get_organization
    RestClient.get("#{root_url}/organization", headers)
  end

  def get_recordings(livestorm_session_id)
    RestClient.get("#{root_url}/sessions/#{livestorm_session_id}/recordings", headers)
  end

  private

  attr_reader :api_token, :root_url

  def headers
    @headers ||= {
      "Authorization" => api_token,
      "Content-Type" => "application/vnd.api+json",
      "Accept" => "application/vnd.api+json"
    }
  end
end
