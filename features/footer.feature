Feature: access legal information, social media pages, contact form with footer

  As a visitor to the website
  So that I can contact WICI
  I should see their email, phone number, facebook account and contact form.

  As a guest,
  So that I can easily contact WICI
  I should see a link to the contact page

  As a guest,
  So that I can easily navigate the website and learn legal information about WICI
  I should see a footer on all pages

  Scenario: click on links in the footer
    Given I am on the home page
    And I follow "contact_footer"
    Then I should see "Contact Us"

  Scenario: footer information visible from home page
    Given I am on the home page
    Then I should see "The Women In Chemistry Initiative"

  Scenario: footer information visible from events page
  	Given I am on the events page
    Then I should see "The Women In Chemistry Initiative"

  Scenario: footer information visible from about page
  	Given I am on the about_index page
    Then I should see "The Women In Chemistry Initiative"

  Scenario: footer information visible from donate page
  	Given I am on the donate page
    Then I should see "The Women In Chemistry Initiative"





