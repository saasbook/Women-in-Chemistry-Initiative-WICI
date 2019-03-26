Feature: view a list of volunteers

  As an admin
  So that I can see if we have enough people working our events
  I want to see a list of people who have signed up to volunteer

  Background:
    Given the following events exist:
      | name              | description                 | date        | location                               | tickets               |
      | Drinking          | Come drink with us          | 25-Nov-2018 | A bar                                  | tinyurl.com/tickets   |
      | Heisenberg Talk   | Is this reference dated yet | 26-Mar-2019 | 456 Wantabo Blvd, New Mexico, AZ 94704 | amc.com/breakingbad   |
      | Meet and greet    | Meet your favorite chemists | 26-Feb-2019 | 123 Treeside Way, Berkeley, CA 94704   | stubhub.com/chemistry |
    And the following volunteers exist:
      | name              | email                        | event             |
      | John Doe          | johnny@berkeley.edu          | Drinking          |
      | Jane Doe          | janey@theberkster.net        | Drinking          |
      | Bob Bobbington II | aaaaaaaahhhhh@emails.io      | Heisenberg Talk   |
      | Slim Shady        | armsspaghetti@google.net     | Heisenberg Talk   |


  Scenario: see lists of volunteers for "Drinking"
    Given I view the event "Drinking"
    When I follow "Volunteers"
    Then I should see the following: "John Doe, Jane Doe"
    And I should not see the following: "Slim Shady, Bob Bobbington II"

  Scenario: see lists of volunteers for "Heisenberg Talk"
    Given I view the event "Heisenberg Talk"
    When I follow "Volunteers"
    Then I should see the following: "Slim Shady, Bob Bobbington II"
    And I should not see the following: "John Doe, Jane Doe"


  Scenario: see no volunteers when none exist
    Given I view the event "Meet and greet"
    When I follow "Volunteers"
    Then I should not see the following: "John Doe, Jane Doe, Slim Shady, Bob Bobbington II"

