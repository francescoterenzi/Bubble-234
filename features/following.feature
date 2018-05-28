Feature: Following

Scenario: I don't have any following users
  Given I am a logged in user
  And another user called "pincopallino" exists
  When I go to the user "pincopallino" profile page
  And I press "Follow"
  Then I should be on the user "pincopallino" profile page
  And I should see "1 Followers"