Feature: Random Cocktail
As a registered user
So that I can try something new
I want to see a random cocktail recipe

Scenario: Getting a Random Cocktail
  Given I am a registered user
  And another users's cocktail "Mojito" exists
  And I log in
  When I follow "Random"
  Then I should be on the random cocktail page
  And I should see "Mojito"
