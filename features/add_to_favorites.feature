Feature: Favourites
  As a registered user
  So that I can remember the cocktails I like
  I want to add them to my favourites

Scenario: Add to favourites
  Given I am a registered user
  And another user's cocktail "Mojito" exists
  And I log in
  And I am on the cocktail "Mojito" page
  And I follow "Add to Favorites"
  And I am on the myprofile page
  Then I should see the link to "Mojito" cocktail