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
  @root_url = 'https://api.livestorm.co/v1'
  @after_request_hook = nil

  # This method is OPTIONAL and used to configure the LivestormApi class
  # Specifically:
  # root_url (string) set the root url for the Livestorm API
  #   defaults to 'https://api.livestorm.co/v1'
  # after_request_hook (proc) to be called after each request
  #   The proc takes a single argument, the response from the request and is
  #   guaranteed to be called after each request
  #   with the result that the response is always returned
  #   example:
  #   LivestormApi.config do |config|
  #    config.after_request_hook = ->(response) { #do something with response }
  #   end

  def self.config
    yield self
  end

  class << self
    attr_accessor :after_request_hook, :root_url
  end

  def initialize(api_token:)
    @api_token = api_token
  end

  def get_ping
    response = RestClient.get("#{self.class.root_url}/ping", headers)
  ensure
    run_after_request_hook(response)
  end

  def get_events(options = {})
    params = { params: options }
    response = RestClient::Request.execute(method: :get, url: "#{self.class.root_url}/events", headers: headers.merge(params))
  ensure
    run_after_request_hook(response)
  end

  # requires an event Hash
  #
  def post_event(event)
    payload = { data: event }.to_json
    response = RestClient.post("#{self.class.root_url}/events", payload, headers)
  ensure
    run_after_request_hook(response)
  end

  # requires an event Hash
  #
  def patch_event(event)
    id = event.delete(:id)
    payload = { data: event }.to_json
    response = RestClient.patch("#{self.class.root_url}/events/#{id}", payload, headers)
  ensure
    run_after_request_hook(response)
  end

  def get_event(livestorm_event_id)
    response = RestClient.get("#{self.class.root_url}/events/#{livestorm_event_id}", headers)
  ensure
    run_after_request_hook(response)
  end

  def get_event_people(livestorm_event_id, options = {})
    params = { params: options }
    response = RestClient::Request.execute(
      method: :get,
      url: "#{self.class.root_url}/events/#{livestorm_event_id}/people",
      headers: headers.merge(params)
    )
  ensure
    run_after_request_hook(response)
  end

  def get_event_person(livestorm_event_id:, livestorm_person_id:)
    response = RestClient.get("#{self.class.root_url}/events/#{livestorm_event_id}/people/#{livestorm_person_id}", headers)
  ensure
    run_after_request_hook(response)
  end

  def get_event_sessions(livestorm_event_id, options = {})
    params = { params: options }
    response = RestClient::Request.execute(
      method: :get,
      url: "#{self.class.root_url}/events/#{livestorm_event_id}/sessions",
      headers: headers.merge(params)
    )
  ensure
    run_after_request_hook(response)
  end

  def post_event_session(session_attrs)
    livestorm_event_id = session_attrs.delete(:livestorm_event_id)
    payload = { data: session_attrs }.to_json
    response = RestClient.post("#{self.class.root_url}/events/#{livestorm_event_id}/sessions", payload, headers)
  ensure
    run_after_request_hook(response)
  end

  def patch_event_session(session_attrs)
    id = session_attrs.delete(:id)
    payload = { data: session_attrs }.to_json
    response = RestClient.patch("#{self.class.root_url}/sessions/#{id}", payload, headers)
  ensure
    run_after_request_hook(response)
  end

  def delete_event_session(livestorm_event_session_id)
    response = RestClient.delete("#{self.class.root_url}/sessions/#{livestorm_event_session_id}", headers)
  ensure
    run_after_request_hook(response)
  end

  def post_register_participant(participant_attrs)
    id = participant_attrs.delete(:session_id)

    payload = { data: participant_attrs }.to_json
    response = RestClient.post("#{self.class.root_url}/sessions/#{id}/people", payload, headers)
  ensure
    run_after_request_hook(response)
  end

  def get_session(livestorm_session_id)
    response = RestClient::Request.execute(
      method: :get,
      url: "#{self.class.root_url}/sessions/#{livestorm_session_id}",
      headers: headers
    )
  ensure
    run_after_request_hook(response)
  end

  def get_session_people(livestorm_session_id)
    response = RestClient::Request.execute(
      method: :get,
      url: "#{self.class.root_url}/sessions/#{livestorm_session_id}/people",
      headers: headers
    )
  ensure
    run_after_request_hook(response)
  end

  def delete_session_people(livestorm_session_id, email)
    response = RestClient::Request.execute(
      method: :delete,
      url: "#{self.class.root_url}/sessions/#{livestorm_session_id}/people?filter[email]=#{email}",
      headers: headers
    )
  ensure
    run_after_request_hook(response)
  end

  # options:
  # {"filter[role]" => "",
  #  "filter[pending_invite]" => "",
  #  "filter[email]" => ""}
  #
  def get_users(options = {})
    params = { params: options }
    response = RestClient.get("#{self.class.root_url}/users", headers.merge(params))
  ensure
    run_after_request_hook(response)
  end

  def post_user(user_attrs)
    payload = { data: user_attrs }.to_json

    response = RestClient.post("#{self.class.root_url}/users", payload, headers)
  ensure
    run_after_request_hook(response)
  end

  # mostly helpful for debugging
  #
  def get_current_user
    response = RestClient.get("#{self.class.root_url}/me", headers)
  ensure
    run_after_request_hook(response)
  end

  # mostly helpful for debugging
  #
  def get_people
    response = RestClient.get("#{self.class.root_url}/people", headers)
  ensure
    run_after_request_hook(response)
  end

  # mostly helpful for debugging
  #
  def get_organization
    response = RestClient.get("#{self.class.root_url}/organization", headers)
  ensure
    run_after_request_hook(response)
  end

  def get_recordings(livestorm_session_id)
    response = RestClient.get("#{self.class.root_url}/sessions/#{livestorm_session_id}/recordings", headers)
  ensure
    run_after_request_hook(response)
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

  # runs the after_request_hook if it is set
  # always returns the response
  #
  def run_after_request_hook(response)
    self.class.after_request_hook.call(response) if self.class.after_request_hook

    response
  end
end
