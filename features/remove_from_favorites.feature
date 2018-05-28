Feature: Delete favourite
    As a registered user
    So that I can no longer have updates about a cocktail
    I want to delete it from my favourites

Scenario: Remove from favorites
    Given I am a registered user
    And I added the cocktail "Mojito" to favorites
    And I am on the cocktail "Mojito" page
    And I follow "Remove from Favorites"
    And I am on the myprofile page
    Then I should not see "Mojito"
