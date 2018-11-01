Feature: Unhandled exceptions for views support

Scenario: Unhandled exceptions are delivered from views
  Given I set environment variable "BUGSNAG_API_KEY" to "a35a2a72bd230ac0aa0f52715bbdc6aa"
  And I configure the bugsnag endpoint
  And I start the service "laravel"
  And I wait for the app to respond on port "61280"
  When I navigate to the route "/unhandled_view_exception" on port "61280"
  And I wait for 1 second
  Then I should receive a request
  And the request is a valid for the error reporting API
  And the request contained the api key "a35a2a72bd230ac0aa0f52715bbdc6aa"
  And the payload field "events" is an array with 1 element
  And the exception "errorClass" equals "ErrorException"
  And the exception "message" starts with "Unhandled exception (View: /app/resources/views/unhandledexception.blade.php)"
  And the event "metaData.request.httpMethod" equals "GET"
  And the event "app.type" equals "HTTP"
  And the event "context" equals "GET /unhandled_view_exception"
  And the event "severity" equals "error"
  And the event "unhandled" is true
  And the event "severityReason.type" equals "unhandledExceptionMiddleware"
  And the event "severityReason.attributes.framework" equals "Laravel"

Scenario: Unhandled errors are delivered from views
  Given I set environment variable "BUGSNAG_API_KEY" to "a35a2a72bd230ac0aa0f52715bbdc6aa"
  And I configure the bugsnag endpoint
  And I start the service "laravel"
  And I wait for the app to respond on port "61280"
  When I navigate to the route "/unhandled_view_error" on port "61280"
  And I wait for 1 second
  Then I should receive a request
  And the request is a valid for the error reporting API
  And the request contained the api key "a35a2a72bd230ac0aa0f52715bbdc6aa"
  And the payload field "events" is an array with 1 element
  And the exception "errorClass" equals "ErrorException"
  And the exception "message" equals "Call to undefined function foo() (View: /app/resources/views/unhandlederror.blade.php)"
  And the event "metaData.request.httpMethod" equals "GET"
  And the event "app.type" equals "HTTP"
  And the event "context" equals "GET /unhandled_view_error"
  And the event "severity" equals "error"
  And the event "unhandled" is true
  And the event "severityReason.type" equals "unhandledExceptionMiddleware"
  And the event "severityReason.attributes.framework" equals "Laravel"

Scenario: Sessions are correct in unhandled exceptions from views
  Given I set environment variable "BUGSNAG_API_KEY" to "a35a2a72bd230ac0aa0f52715bbdc6aa"
  And I configure the bugsnag endpoint
  And I enable session tracking
  And I start the service "laravel"
  And I wait for the app to respond on port "61280"
  When I navigate to the route "/unhandled_view_exception" on port "61280"
  And I wait for 1 second
  Then I should receive 2 requests
  And the request 0 is valid for the session tracking API
  And the request 1 is a valid for the error reporting API
  And the payload has a valid sessions array for request 0
  And the payload field "events.0.session.events.unhandled" equals 1 for request 1
  And the payload field "events.0.session.events.handled" equals 0 for request 1