Feature: Unhandled exceptions for routing support

Scenario: Unhandled exceptions are delivered from routing
  Given I start the laravel fixture
  When I navigate to the route "/unhandled_exception"
  Then I wait to receive an error
  And the error is valid for the error reporting API version "4.0" for the "Bugsnag Laravel" notifier
  And the exception "errorClass" equals "Exception"
  And the exception "message" starts with "Crashing exception!"
  And the event "metaData.request.httpMethod" equals "GET"
  And the event "app.type" equals "HTTP"
  And the event "context" equals "GET /unhandled_exception"
  And the event "severity" equals "error"
  And the event "unhandled" is true
  And the event "severityReason.type" equals "unhandledExceptionMiddleware"
  And the event "severityReason.attributes.framework" equals "Laravel"

Scenario: Unhandled errors are delivered from routing
  Given I start the laravel fixture
  When I navigate to the route "/unhandled_error"
  Then I wait to receive an error
  And the error is valid for the error reporting API version "4.0" for the "Bugsnag Laravel" notifier
  And the exception "errorClass" ends with "Error"
  And the exception "message" equals "Call to undefined function call_foo()"
  And the event "metaData.request.httpMethod" equals "GET"
  And the event "app.type" equals "HTTP"
  And the event "context" equals "GET /unhandled_error"
  And the event "severity" equals "error"
  And the event "unhandled" is true
  And the event "severityReason.type" equals "unhandledExceptionMiddleware"
  And the event "severityReason.attributes.framework" equals "Laravel"

@requires-sessions
Scenario: Sessions are correct in unhandled exceptions from routing
  Given I enable session tracking
  And I start the laravel fixture
  When I navigate to the route "/unhandled_exception"
  And I wait to receive a session
  Then the session is valid for the session reporting API version "1.0" for the "Bugsnag Laravel" notifier
  When I wait to receive an error
  Then the error is valid for the error reporting API version "4.0" for the "Bugsnag Laravel" notifier
  And the error payload field "events.0.session.events.unhandled" equals 1
  And the error payload field "events.0.session.events.handled" equals 0
