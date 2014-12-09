Feature: Log in/out links
  In order to easily log in
  As a user
  I want to see a "Login" link

  Scenario: A guest user should see a login link
    Given I am not logged in
    And I am on the e-Shelf
    Then I should see a "Login" link
