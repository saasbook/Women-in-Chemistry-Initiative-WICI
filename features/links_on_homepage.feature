Feature: navigate the website with links on homepage

  As visitor to the website
  So that I can browse content relevant to my interests
  I want to be able to click links on the homepage to navigate the site

  Background:
    Given I am on the home page

  Scenario: click on events
    When I follow "events"
    Then I should see "Events"

  Scenario: click on about
    When I follow "about"
    Then I should see "About"

  Scenario: click on donate
    When I follow "donate"
    Then I should see "donate"

  Scenario: click on contact
    When I follow "contact"
    Then I should see "Contact Form"
