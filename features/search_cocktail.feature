Feature: Search cocktail by keyword 
  As a user
  So that I can find what I’m looking for
  I want to search a cocktail by one or more keywords


Scenario: Found cocktails
  Given I am a registered user
  And another user's cocktail Cuba Libre exists
  When I log in
  And I am on the home page
  When I search the cocktail Cuba Libre
  Then I should be on the cocktails results page
  And I should see "Cuba Libre"