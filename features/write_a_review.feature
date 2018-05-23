Feature: Write a Review
  As a registered user
  So that I can share my thoughts about a cocktail
  I want to write a review

Scenario: Write a review
  Given I am a registered user
  And another users's cocktail "Mojito" exists
  And I log in
  When I go to the cocktail "Mojito" page
  And I follow "Add a Review"
  When I select "3" from "Rate"
  And I fill in "Comments" with "Il più buono di tutti"
  And I press "Create Review"
  Then I should see "Rate: 3"
