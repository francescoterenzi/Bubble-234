Feature: Conversations
    As a registered user
    So that I can chat with people
    I want to start a conversations

Scenario: Start a conversations
    Given I am a registered user
    And another user called "pinco_pallino" exists
    And I log in
    When I am on the conversations page
    And I follow "pinco_pallino"
    Then I should see the window of the conversation with "pinco_pallino"