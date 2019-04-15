Feature: Add and view tasks

  As a administrator on the website
  So that I can organize event preparation
  I want to be able to add and view tasks

  Background:
    Given the following events exist:
      | name              | description                 | date        | location                               | tickets               | capacity |
      | Pouring liquid    | Look, it changes colors     | 22-Apr-3019 | 422 Treeside Way, Berkeley, CA 94704   | stubhub.com/liquid    | 10       |
    And I am on the events page
    And I follow "Show"

  Scenario: I add a task:
    When I follow "Add Task"
    And I fill out the form with the following attributes:
      | name    | Test           |
      | description     | a chore     |
    Then I should see "You have successfully added a new task!"
    When I follow "Tasks"
    Then I should see "Test"
    When I follow "Show"
    When I follow "Edit"
    And I fill out the form with the following attributes:
      | name    | New           |
      | description     | a chore          |
    Then I should see "a chore"
    When I follow "Show"
    And I follow "Destroy"
    Then I should not see "a chore"
