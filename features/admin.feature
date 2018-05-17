Feature: Admin
As a administrator user
So that I can delete a user
I want to have access to a user profile

Scenario: Admin access granted
 Given I am a logged in admin user
 And I am on the home page
 When I follow "Admin"
 Then I should be on the admin page
 And I should see "Admin"

 Scenario: User access denied
  Given I am a logged in user
  And I am on the home page
  Then I should not see "Admin"
  When I go to the admin page
  Then I should be on the home page
  And I should see "You are not authorized to access this page."