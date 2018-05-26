Feature: Delete a cocktail
    As a logged user
    So that I can lo longer share my recepie
    I want to delete my cocktail

Scenario: Delete a cocktail
    Given I created the cocktail "Cubalibre"
    And I go to the cocktail "Cubalibre" page
    And I follow "Delete"
    Then I should see "deleted."
