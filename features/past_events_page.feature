Feature: Use the past events page

  As visitor to the website
  So that I can browse previous events
  I want to be able to see the past events and their details

  Background:
    Given the following events exist:
      | name              | description                 | date        | location                               | tickets               |
      | Drinking          | Come drink with us          | 25-Nov-2018 | A bar                                  | tinyurl.com/tickets   |
      | Heisenberg Talk   | Is this reference dated yet | 26-Mar-2019 | 456 Wantabo Blvd, New Mexico, AZ 94704 | amc.com/breakingbad   |
      | Beakers Quarterly | To beak or not to beak      | 20-Apr-3019 | 8888 Haste St, Berkeley, CA 94704      | beakers.com/wici      |
      | Meet and greet    | Meet your favorite chemists | 26-Feb-2019 | 123 Treeside Way, Berkeley, CA 94704   | stubhub.com/chemistry |
      | Pouring liquid    | Look, it changes colors     | 01-Apr-2019 | 422 Treeside Way, Berkeley, CA 94704   | stubhub.com/liquid    |
    And I am on the past events page

  Scenario: ensure there is only past events
    Then I should see "Drinking"
    And I should see "Heisenberg Talk" before "Meet and greet"
    But I should not see "Beakers Quarterly"
