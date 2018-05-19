Feature: Search A User By Nickname
As a registered user
So that I can find someone
I want to search a user by nickname

Scenario: Found users
Given I am a logged in user
And I am on the home page
When I search test
Then I should be on the results page
And I should see "test"

Scenario: No users found
Given I am a logged in user
And I am on the home page
When I try to search an user that doesn't exist
Then I should be on the home page
And I should see "No users found!"