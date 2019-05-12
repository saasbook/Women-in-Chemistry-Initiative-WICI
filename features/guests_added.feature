Feature: See if you are attending an event

  As a visitor to the website
  So that I can see if my name was registered to an event
  I want to be able to click to see who is going to an event

  Background:
    Given the following events exist:
      | name              | description                 | date        | location                               | capacity | price | has_tickets |
      | Pouring liquid    | Look, it changes colors     | 22-Apr-3019 | 422 Treeside Way, Berkeley, CA 94704   | 10       | 0     | 0           |
      | Other event       | Look, it changes colors     | 22-Apr-3019 | 422 Treeside Way, Berkeley, CA 94704   | 0        | 0     | 0           |
    And I am on the events page

  Scenario: I register for an event with no demographics:
    Given I am on the first event rsvp page
    And I submit the form with the following attributes:
      | firstname    | Test           |
      | lastname     | Guest          |
      | email        | test@guest.com |
    Then I should see "You have successfully registered!"
    And I should see "Test Guest"

  Scenario: Delete a guest
    Given I am logged in as an admin
    And I am on the first event rsvp page
    And I submit the form with the following attributes:
      | firstname    | Test           |
      | lastname     | Guest          |
      | email        | test@guest.com |
    And I am on the first event page
    And I follow "Delete"
    Then I should see "Guest was successfully removed."

  Scenario: I register for an event with demographics:
    When I follow "rsvp_1"
    And I fill out the form with the following attributes:
      | firstname         | Test           |
      | lastname          | Guest          |
      | email             | test@guest.com |
    And I select the following attributes:
      | occupation        | Undergrad      |
      | gender            | Male           |
      | department        | Chemistry      |
    And I press "submit"
    Then I should see "You have successfully registered!"
    And I should see "Test Guest"

  Scenario: Capacity is reached
    When I follow "rsvp_2"
    And I submit the form with the following attributes:
      | firstname    | Test           |
      | lastname     | Guest          |
      | email        | test@guest.com |
    Then I should see "Your registration failed, please make sure your information is correct."

  Scenario: Bad email
    When I follow "rsvp_1"
    And I submit the form with the following attributes:
      | firstname    | Test           |
      | lastname     | Guest          |
      | email        | test           |
    Then I should see "Your registration failed, please make sure your information is correct."

  Scenario: Testing Pie charts
    Given I am logged in as an admin
    And I am on the events page
    And the following guests exist:
        | firstname      | lastname         | email        | occupation           | gender             | department          | event_id|
        | John           | Doe              | jd@gmail.com | Undergrad            | Male               | Chemistry           | 1       |
        | Sara           | Sen              | ss@gmail.com | Graduate             | Female             | Chemical Engineering| 1       |
        | Steph          | Curry            | sc@gmail.com | Postdoc              | Male               | Stem non-chemistry  | 1       |
        | Tara           | Gon              | tg@gmail.com | Faculty Staff        | Prefer not to say  | Other               | 1       |
        | Alex           | Morgan           | am@gmail.com | Other                | Female             | Other               | 1       |
        | Sasha          | Downer           | sd@gmail.com | Postdoc              | Other              | Stem non-chemistry  | 1       |
    When I follow "show_1"
    Then I should see "Loading..."
