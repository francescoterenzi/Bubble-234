Feature: TwitterLogin
Twitter login
As a Twitter user
So that I can access the service
I want to login with my Twitter credentials

@omniauth_test
Scenario: Users logs in with Twitter
  Given I am on the home page
  And I am not authenticated
  When I sign in with Twitter provider
  Then I should be on the myprofile page
  And I should see "Successfully authenticated from Twitter account."
