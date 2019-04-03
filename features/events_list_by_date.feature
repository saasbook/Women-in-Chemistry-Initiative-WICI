
Feature: navigate the website with links on homepage

  As visitor to the website
  So that I can browse content relevant to my interests
  I want to be able to click links on the homepage to navigate the site

  Background:
    Given the following events exist:
      | name              | description                 | date        | location                               | tickets               |
      | Drinking          | Come drink with us          | 25-Nov-3018 | A bar                                  | tinyurl.com/tickets   |
      | Heisenberg Talk   | Is this reference dated yet | 26-Mar-3019 | 456 Wantabo Blvd, New Mexico, AZ 94704 | amc.com/breakingbad   |
      | Beakers Quarterly | To beak or not to beak      | 20-Feb-2019 | 8888 Haste St, Berkeley, CA 94704      | beakers.com/wici      |
      | Meet and greet    | Meet your favorite chemists | 26-Feb-3019 | 123 Treeside Way, Berkeley, CA 94704   | stubhub.com/chemistry |
      | Pouring liquid    | Look, it changes colors     | 22-Apr-3019 | 422 Treeside Way, Berkeley, CA 94704   | stubhub.com/liquid    |


  Scenario: browsing the events page in order
    Given I am on the events page
    Then 5 events should exist
    And I should see "Meet and greet" before "Heisenberg Talk"
    And I should not see "Beakers Quarterly"
