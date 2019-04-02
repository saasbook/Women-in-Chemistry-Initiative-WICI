Feature: sign up to volunteer for an event

  As an interested volunteer
  So that I can let people know what events I will be at
  I want to be able to sign up to volunteer

  Background:
    Given the following events exist:
      | name              | description                 | date        | location                               | tickets               |
      | Drinking          | Come drink with us          | 25-Nov-2018 | A bar                                  | tinyurl.com/tickets   |
    And I view the event "Drinking"
    And I follow "Volunteers"
    And I follow "Sign up as a Volunteer"

  Scenario: signing up as a volunteer
    Given I fill in "Name" with "Bob Saget"
    And I fill in "Email" with "bobbie@gmail.com"
    When I press "Submit"
    Then I should see "You are now a volunteer"
    And I should see "Bob Saget"

  Scenario: incorrect name format
    Given I fill in "Name" with "Bob"
    And I fill in "Email" with "Bob@gmail.com"
    When I press "Submit"
    Then I should see "Name should have format: Firstname Lastname"

  Scenario: incorrect email format
    Given I fill in "Name" with "Bob Saget"
    And I fill in "Email" with "I use gmail"
    When I press "Submit"
    Then I should see "Email is invalid"

  Scenario: nothing filled in
    When I press "Submit"
    Then I should see "Email is invalid"
    And I should see "Name should have format: Firstname Lastname"

