Feature: Following

Scenario: I don't have any following users
  Given I am a registered user
  And another user called "pincopallino" exists
  When I log in
  And I visit the profile of "pincopallino"
  And I follow "Follow"
  And I go to the myprofile page
  Then I should see the link to "pincopallino" profile page
