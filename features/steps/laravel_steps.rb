require 'net/http'

When("I configure the bugsnag endpoint") do
  steps %Q{
    When I set environment variable "BUGSNAG_ENDPOINT" to "http://#{current_ip}:#{MOCK_API_PORT}"
  }
end

When(/^I install the current bugsnag-laravel branch to "(.+)"$/) do |fixture|
  install_current_branch(fixture)
end

When("I wait for the app to respond on port {string}") do |port|
  max_attempts = ENV.include?('MAX_MAZE_CONNECT_ATTEMPTS')? ENV['MAX_MAZE_CONNECT_ATTEMPTS'].to_i : 10
  attempts = 0
  up = false
  until (attempts >= max_attempts) || up
    attempts += 1
    begin
      uri = URI("http://localhost:#{port}/")
      response = Net::HTTP.get_response(uri)
      up = (response.code == "200")
    rescue EOFError
    end
    sleep 1
  end
  raise "App not ready in time!" unless up
end

When("I navigate to the route {string} on port {string}") do |route, port|
  steps %Q{
    When I open the URL "http://localhost:#{port}#{route}"
    And I wait for 1 second
  }
end

Then("the request used payload v4 headers") do
  steps %Q{
    Then the "bugsnag-api-key" header is not null
    And the "bugsnag-payload-version" header equals "4.0"
    And the "bugsnag-sent-at" header is a timestamp
  }
end

Then("the request contained the api key {string}") do |api_key|
  steps %Q{
    Then the "bugsnag-api-key" header equals "#{api_key}"
    And the payload field "apiKey" equals "#{api_key}"
  }
end

Then("the request used the Laravel notifier") do
  steps %Q{
    Then the payload field "notifier.name" equals "Bugsnag Laravel"
  }
end