Feature: Add and view tasks

  As a administrator on the website
  So that I can organize event preparation
  I want to be able to add and view tasks

  Background:
    Given the following events exist:
      | name              | description                 | date        | location                               | tickets               | capacity |
      | Pouring liquid    | Look, it changes colors     | 22-Apr-3019 | 422 Treeside Way, Berkeley, CA 94704   | stubhub.com/liquid    | 10       |
    And for Pouring liquid the following tasks exist:
      | name              | description                 | deadline        |
      | get liquid   | Look, it changes colors     | 28-Apr-3019 |
    And I am on the tasks page

  Scenario: Correctly stores tasks
    Then 1 tasks should exist

  Scenario: I can view a task:
    Then I should see "get liquid"

  Scenario: I can edit a task:
    When I edit get liquid to:
    | name              | description                 | deadline        |
    | new liquid   |   Look, it changes colors     | 28-Apr-3019 |
    And I follow "Show"
    Then I should see "new liquid"

  Scenario: Edit as user:
    Given I am on the first task edit page
    And I fill out the form with the following attributes:
      | name    | whatever  |
      | description     | a chore  |
    Then I should see "whatever"

  Scenario: Add task as user:
    Given I am on the add task page
    And I fill out the form with the following attributes:
      | name    | whatever  |
      | description     | a chore  |
    Then I should see "You have successfully added a new task!"

  Scenario: I can delete a task
    When I follow "Show"
    And I follow "Destroy"
    Then I should not see "get liquid"
    And 0 tasks should exist

  Scenario: Incorrectly add a task:
  When I follow "Add Task"
  And I fill out the form with the following attributes:
    | description     | a chore  |
  Then I should see "Your Task creation failed."
