Feature: Delite a Review
  As a registered user
  So that I can no longer have thoughts about a cocktail
  I want to delete a review

Scenario: Write a review
  Given I am a registered user
  And I wrote a review for "Mojito" cocktail
  When I go to the cocktail "Mojito" reviews page
  And I follow "details of test review"
  And I follow "Delete Review"
  And I should see "test's Review deleted "
