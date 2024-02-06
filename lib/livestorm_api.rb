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
  ROOT_URL = "https://api.livestorm.co/v1"

  def initialize(api_token:)
    @api_token = api_token
  end

  def get_ping
    notify_remaining_ratelimit(RestClient.get("#{ROOT_URL}/ping", headers))
  end

  def get_events(options = {})
    params = { params: options }
    notify_remaining_ratelimit(
      RestClient::Request.execute(method: :get, url: "#{ROOT_URL}/events", headers: headers.merge(params))
    )
  end

  # requires an event Hash
  #
  def post_event(event)
    payload = { data: event }.to_json
    notify_remaining_ratelimit(RestClient.post("#{ROOT_URL}/events", payload, headers))
  end

  # requires an event Hash
  #
  def patch_event(event)
    id = event.delete(:id)
    payload = { data: event }.to_json
    notify_remaining_ratelimit(RestClient.patch("#{ROOT_URL}/events/#{id}", payload, headers))
  end

  def get_event(livestorm_event_id)
    notify_remaining_ratelimit(
      RestClient.get("#{ROOT_URL}/events/#{livestorm_event_id}", headers)
    )
  end

  def get_event_people(livestorm_event_id, options = {})
    params = { params: options }
    notify_remaining_ratelimit(
      RestClient::Request.execute(
        method: :get,
        url: "#{ROOT_URL}/events/#{livestorm_event_id}/people",
        headers: headers.merge(params)
      )
    )
  end

  def get_event_person(livestorm_event_id:, livestorm_person_id:)
    notify_remaining_ratelimit(
      RestClient.get("#{ROOT_URL}/events/#{livestorm_event_id}/people/#{livestorm_person_id}", headers)
    )
  end

  def get_event_sessions(livestorm_event_id, options = {})
    params = { params: options }
    notify_remaining_ratelimit(
      RestClient::Request.execute(
        method: :get,
        url: "#{ROOT_URL}/events/#{livestorm_event_id}/sessions",
        headers: headers.merge(params)
      )
    )
  end

  def post_event_session(session_attrs)
    livestorm_event_id = session_attrs.delete(:livestorm_event_id)
    payload = { data: session_attrs }.to_json
    notify_remaining_ratelimit(RestClient.post("#{ROOT_URL}/events/#{livestorm_event_id}/sessions", payload, headers))
  end

  def patch_event_session(session_attrs)
    id = session_attrs.delete(:id)
    payload = { data: session_attrs }.to_json
    notify_remaining_ratelimit(RestClient.patch("#{ROOT_URL}/sessions/#{id}", payload, headers))
  end

  def delete_event_session(livestorm_event_session_id)
    notify_remaining_ratelimit(RestClient.delete("#{ROOT_URL}/sessions/#{livestorm_event_session_id}", headers))
  end

  def post_register_participant(participant_attrs)
    id = participant_attrs.delete(:session_id)

    payload = { data: participant_attrs }.to_json
    notify_remaining_ratelimit(RestClient.post("#{ROOT_URL}/sessions/#{id}/people", payload, headers))
  end

  def get_session(livestorm_session_id)
    notify_remaining_ratelimit(
      RestClient::Request.execute(
        method: :get,
        url: "#{ROOT_URL}/sessions/#{livestorm_session_id}",
        headers: headers
      )
    )
  end

  def get_session_people(livestorm_session_id)
    notify_remaining_ratelimit(
      RestClient::Request.execute(
        method: :get,
        url: "#{ROOT_URL}/sessions/#{livestorm_session_id}/people",
        headers: headers
      )
    )
  end

  def delete_session_people(livestorm_session_id, email)
    notify_remaining_ratelimit(
      RestClient::Request.execute(
        method: :delete,
        url: "#{ROOT_URL}/sessions/#{livestorm_session_id}/people?filter[email]=#{email}",
        headers: headers
      )
    )
  end

  # options:
  # {"filter[role]" => "",
  #  "filter[pending_invite]" => "",
  #  "filter[email]" => ""}
  #
  def get_users(options = {})
    params = { params: options }
    notify_remaining_ratelimit(
      RestClient.get("#{ROOT_URL}/users", headers.merge(params))
    )
  end

  def post_user(user_attrs)
    payload = { data: user_attrs }.to_json

    notify_remaining_ratelimit(RestClient.post("#{ROOT_URL}/users", payload, headers))
  end

  # mostly helpful for debugging
  #
  def get_current_user
    notify_remaining_ratelimit(
      RestClient.get("#{ROOT_URL}/me", headers)
    )
  end

  # mostly helpful for debugging
  #d
  def get_people
    notify_remaining_ratelimit(
      RestClient.get("#{ROOT_URL}/people", headers)
    )
  end

  # mostly helpful for debugging
  #
  def get_organization
    notify_remaining_ratelimit(
      RestClient.get("#{ROOT_URL}/organization", headers)
    )
  end

  def get_recordings(livestorm_session_id)
    RestClient.get("#{ROOT_URL}/sessions/#{livestorm_session_id}/recordings", headers)
  end

  private

  attr_reader :api_token

  def headers
    @headers ||= {
      "Authorization" => api_token,
      "Content-Type" => "application/vnd.api+json",
      "Accept" => "application/vnd.api+json"
    }
  end

  def notify_remaining_ratelimit(response)
    message = get_log_message response
    if message
      if defined?(Honeybadger)
        Honeybadger.notify(message)
      else
        Logger.new(STDOUT).warn(message)
      end
    end

    response
  end

  def get_log_message response
    remaining = response.headers[:ratelimit_monthly_remaining].to_f
    total = response.headers[:ratelimit_monthly_limit].to_f

    return "Livestorm perodic limit is unidentified.  remaining: #{remaining}, total: #{total}." if remaining.zero? && total.zero?

    "Livestorm periodic limit nearly reached!" if (remaining / total) < 0.2
  end
end
