Feature: view a list of volunteers for a task

  As an admin
  So that I can see what tasks have been assigned
  I want to see a list of people who have signed up to volunteer

  Background:
    Given the following events exist:
      | name              | description                 | date        | location                               | tickets               | capacity |
      | Pouring liquid    | Look, it changes colors     | 22-Apr-3019 | 422 Treeside Way, Berkeley, CA 94704   | stubhub.com/liquid    | 10       |
    And for Pouring liquid the following tasks exist:
      | name              | description                 | deadline        |
      | get liquid   | Look, it changes colors     | 28-Apr-3019 |
      | drink liquid | I don't feel so good        | 29-Apr-3019 |
    And the following volunteers exist:
      | firstname | lastname | email        | password |
      | John      | Doe      | john@doe.com | 123456   |
      | Jane      | Doe      | jane@doe.com | 123456   |
    And I am on the tasks page for the first event

  Scenario: become a volunteer for "get liquid" and "drink liquid"
    Given I am logged in as a volunteer named "Zip Zappity"
    And "Zip" is a volunteer for "drink liquid"
    And I view the task "get liquid"
    When I follow "sign up"
    And I press "Confirm"
    Then I should see the following: "Zip, Zappity"

  Scenario: stop being a volunteer for "get liquid"
    Given I am logged in as a volunteer named "Zip Zappity"
    And "Zip" is a volunteer for "get liquid"
    When I view the task "get liquid"
    And I follow "delete"
    Then I should not see "Zip"

  Scenario: can only volunteer for a task once
    Given I am logged in as a volunteer named "Zip Zappity"
    And "Zip" is a volunteer for "get liquid"
    When I view the task "get liquid"
    When I follow "sign up"
    Then I should see "already a volunteer"

  Scenario: volunteer cannot delete another volunteer
    Given I am logged in as a volunteer named "Zip Zappity"
    And "John" is a volunteer for "get liquid"
    When I view the task "get liquid"
    Then I should not see "delete"

  Scenario: admin can delete volunteers
    Given I am logged in as an admin named "Zop Zoppity"
    And "John" is a volunteer for "get liquid"
    When I view the task "get liquid"
    Then I should see "Delete"

  Scenario: see no volunteers when none exist
    Given I am logged in as a volunteer named "Zip Zappity"
    When I view the task "drink liquid"
    Then I should not see the following: "Zip, Zappity"
    And I should see "no volunteers"

