Feature: GoogleLogin
Google login
As a Google user
So that I can access the service
I want to login with my Google credentials

@omniauth_test
Scenario: Users logs in with Google
  Given I am on the home page
  And I am not authenticated
  When I sign in with Google_oauth2 provider
  Then I should be on the myprofile page
  And I should see "Successfully authenticated from Google account."