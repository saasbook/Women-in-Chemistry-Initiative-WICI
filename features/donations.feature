Feature: donating money as a guest

  As visitor to the website
  So that I can browse support women in chemistry
  I want to be able to donate money

  Background:
    Given I am on the donate page

  Scenario: Donating $25
    Given I donate $25
    Then I should see "$25.00"
    And I should be on the new donation page

  Scenario: Donating an invalid amount
    Given I donate $13.333
    Then I should see "Please enter a valid amount in USD to donate!"
    And I should be on the donate page

#  Scenario: Authorizing payment
#    Given I donate $10
#    And I authorize payment
