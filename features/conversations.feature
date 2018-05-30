Feature: Conversations
    As a registered user
    So that I can chat with people
    I want to start a conversations

Scenario: Start a conversations
    Given another user exists
    And I am a registered user
    And I log in
    When I am on the chat page
    And I follow "chat with fake_test"
    Then I should see "fake_test"