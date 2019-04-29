Feature: View photos on the home page

  As visitor to the website
  So that I can view photos from past events
  I want to be able to click on photos and use next/previous but


  Background:
    Given I am on the home page

  Scenario: click on an image and see it
    When I press the first image
    Then I should see the first image

  Scenario: use the next button to see the next photo
    When I press the first image
    And I press "Next"
    Then I should see the second image

  Scenario: use the previous button to see the last photo
    When I press the first image
    And I press "Previous"
    Then I should see the last image
