Feature: View photos on the home page

  As visitor to the website
  So that I can view photos from past events
  I want to be able see uploaded photos and captions


  Background:
    Given I am on the home page

  Scenario: admins can edit gallery
    Given I am logged in as an admin named "Zip Zappity"
    And I follow "Edit Gallery"
    Then I should see "New Photo"

  Scenario: users cannot edit gallery
    Then I should not see "Edit Gallery"

  Scenario: users can see mission statement
    Then I should see "Mission Statement"
