Feature: Reviews
    As a registered user
    So that I can share my thoughts about a cocktail
    I want to write a review

Scenario: Write a review
    Given I am a registered user
    And another user's cocktail "Mojito" exists
    And I log in
    When I go to the cocktail "Mojito" page
    And I follow "Add a Review"
    When I select "3" from "Rate"
    And I fill in "Comments" with "buono"
    And I press "Create Review"
    Then I should see "Rate: 3"
  
Scenario: Edit a review
    Given I am a registered user
    And I wrote a review for "Mojito" cocktail
    When I go to the cocktail "Mojito" page
    And I follow "Show More"
    Then I follow "Edit"
    When I select "2" from "Rate"
    And I fill in "Comments" with "buonissimo"
    And I press "Save Changes"
    Then I should see "Your review was successfully updated "
  
Scenario: Delete a review
    Given I am a registered user
    And I wrote a review for "Mojito" cocktail
    When I go to the cocktail "Mojito" page
    And I follow "Show More"
    And I follow "Delete Review"
    And I should see "test's Review deleted "
