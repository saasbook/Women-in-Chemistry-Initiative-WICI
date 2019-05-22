Feature: admins can approve volunteers and admins

  As an admin
  So that I can verify new accounts
  I want to approve all accounts before use

  Background:
    Given the following volunteers exist:
      | firstname | lastname | email        | approved | password |
      | John      | Doe      | john@doe.com | true     | 123456   |
      | Jane      | Doe      | jane@doe.com | false    | 123456   |
    And the following admins exist:
      | firstname | lastname | email        | approved | password |
      | Admini    | Strator  | the@boss.com | true     | 123456   |
      | Bad       | Admin    | hacker@w.com | false    | 123456   |
    And I am on the homepage

  Scenario: admin approves a volunteer
    Given I am logged in as an admin
    And I am on the accounts page
    When I approve the volunteer "jane@doe.com"
    Then I should see "Volunteer approved."
    And the volunteer "jane@doe.com" should be approved

  Scenario: admin deletes a volunteer
    Given I am logged in as an admin
    And I am on the accounts page
    When I delete the volunteer "john@doe.com"
    Then I should see "Volunteer deleted."
    And the volunteer "john@doe.com" should not exist

  Scenario: admin denys a volunteer
    Given I am logged in as an admin
    And I am on the accounts page
    When I delete the volunteer "jane@doe.com"
    Then I should see "Volunteer deleted."
    And the volunteer "jane@doe.com" should not exist

  Scenario: admin approves an admin
    Given I am logged in as an admin
    And I am on the accounts page
    When I approve the admin "hacker@w.com"
    Then I should see "Admin approved."
    And the admin "hacker@w.com" should be approved

  Scenario: admin deletes an admin
    Given I am logged in as an admin
    And I am on the accounts page
    When I delete the admin "the@boss.com"
    Then I should see "Admin deleted."
    And the admin "the@boss.com" should not exist

  Scenario: admin denys an admin
    Given I am logged in as an admin
    And I am on the accounts page
    When I delete the admin "hacker@w.com"
    Then I should see "Admin deleted."
    And the admin "hacker@w.com" should not exist

  Scenario: volunteer cannot access accounts page
    Given I am logged in as a volunteer
    And I go to the accounts page
    Then I should be on the home page

  Scenario: volunteer cannot login without approval
    Given I am logged in as an unapproved volunteer
    Then I should see "Your account must be approved by your administrator."
    And I should not see "Sign Out"

  Scenario: volunteer cannot reset password without approval
    Given I am on the sign in page for volunteers
    When I follow "Forgot your password?"
    And I fill in "Email" with "jane@doe.com"
    And I press "submit"
    Then I should see "Your account must be approved by your administrator."

  Scenario: admin cannot reset password without approval
    Given I am on the sign in page for admins
    When I follow "Forgot your password?"
    And I fill in "Email" with "hacker@w.com"
    And I press "submit"
    Then I should see "Your account must be approved by your administrator."
