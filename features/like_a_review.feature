Feature: Like a Review
  As a registered user
  So that I can show to people my thoughts about a review
  I want to like a review

Scenario: Like a Review
  Given I am a registered user
  When I log in
  And I create a cocktail "Mojito"
  And I log out
  And another user's review for "Mojito" cocktail exists
  When I log in
  And I am on the cocktail "Mojito" page
  And I follow "Show More"
  And I press the button with "like" id 
  Then I should see "Likes: 1 people like this"