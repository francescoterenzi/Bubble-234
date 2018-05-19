Feature: Edit a Review
  As a registered user
  So that I can change my thoughts about a cocktail
  I want to edit a review

Scenario: Edit a review
  Given I am a registered user
  And I wrote a review for "Mojito" cocktail
  When I go to the cocktail "Mojito" reviews page
  And I follow "details of test review"
  Then I follow "Edit"
  When I select "2" from "Rate"
  And I fill in "Comments" with "Il più buonissimo di tutti"
  And I press "Save Changes"
  Then I should see "Your review was successfully updated "