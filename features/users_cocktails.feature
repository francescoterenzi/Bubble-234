Feature: User's Cocktails

Scenario: I have at least one cocktail
  Given I am a registered user
  When I log in
  And I create a cocktail "Mojito"
  When I go to the myprofile page
  Then I should see the link to "Mojito" cocktail 

Scenario: I haven't any cocktail
    Given I am a registered user
    When I log in
    When I go to the myprofile page
    Then I should see "0 Cocktails"