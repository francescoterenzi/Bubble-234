Feature: Login
As a registered user
So that I can access the service
I want to login with my credentials

Scenario: Successful Login
  When I am a registered user
  And I am on the home page
  And I am not authenticated
  When I log in
  Then I should be on the myprofile page
  And I should see "Signed in successfully."

Scenario: Failed Login
  Given I am not a registered user
  And I am on the home page
  And I am not authenticated
  When I log in
  Then I should be on the login page
  And I should see "Invalid Login or password."