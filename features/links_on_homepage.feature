Feature: navigate the website with links on homepage

  As visitor to the website
  So that I can browse content relevant to my interests
  I want to be able to click links on the homepage to navigate the site

  Background:
    Given I am on the home page

  Scenario: click on events
    When I follow "events"
    Then I should see "Events"
