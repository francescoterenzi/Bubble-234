Feature: User's Reviews

Scenario: I made at least one review
  Given I am a registered user
  And I wrote a review for "Mojito" cocktail
  When I go to the myprofile page
  Then I should see the link to "Mojito" review 

Scenario: I didn't make any review
  Given I am a registered user
  When I log in
  When I go to the myprofile page
  Then I should see "No reviews yet"  
