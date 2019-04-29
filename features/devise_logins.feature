Feature: volunteers and admins can sign up and log in

  As a user
  So that I can take on a role
  I want to login as a admin or volunteer

  Background:
    Given the following volunteers exist:
      | firstname | lastname | email        | password |
      | John      | Doe      | john@doe.com | 123456   |
      | Jane      | Doe      | jane@doe.com | 123456   |
    And the following admins exist:
      | firstname | lastname | email        | password |
      | Admini    | Strator  | the@boss.com | 123456   |
    And I am on the homepage

  Scenario: can log in as a volunteer
    Given I am on the sign in page for volunteers
    When I log in with the following attributes:
      | Email    | john@doe.com |
      | Password | 123456 |
    Then I should see "Sign Out"

  Scenario: cannot log in again as a volunteer
    Given I am logged in as a volunteer
    When I am on the sign in page for volunteers
    Then I should see "You are already signed in."

  Scenario: can log out as a volunteer
    Given I am logged in as a volunteer
    And I follow "Sign Out"
    Then I should see "Signed out successfully"

  Scenario: volunteer cannot log in as admin
    Given I am logged in as a volunteer
    When I am on the sign in page for admins
    Then I should be on the home page

  Scenario: can log in as an admin
    Given I am on the sign in page for admins
    When I log in with the following attributes:
      | Email    | the@boss.com  |
      | Password | 123456 |
    Then I should see "Sign Out"

  Scenario: cannot log in again as an admin
    Given I am logged in as an admin
    When I am on the sign in page for admins
    Then I should see "You are already signed in."

  Scenario: can log out as an admin
    Given I am logged in as an admin
    And I follow "Sign Out"
    Then I should see "Signed out successfully"

  Scenario: admin cannot log in as volunteer
    Given I am logged in as an admin
    When I am on the sign in page for volunteers
    Then I should be on the home page

