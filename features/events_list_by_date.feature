Feature: See upcoming events

  As visitor to the website
  So that I attend events relevant to my interests
  I want to be able to see events that are happening soon

  Background:
    Given the following events exist:
      | name              | description                 | date        | location                               | capacity | price |
      | Drinking          | Come drink with us          | 25-Nov-3018 | A bar                                  | 200      | 0     |
      | Heisenberg Talk   | Is this reference dated yet | 26-Mar-3019 | 456 Wantabo Blvd, New Mexico, AZ 94704 | 100      | 10    |
      | Beakers Quarterly | To beak or not to beak      | 20-Feb-2019 | 8888 Haste St, Berkeley, CA 94704      | 50       | 20    |
      | Meet and greet    | Meet your favorite chemists | 26-Feb-3019 | 123 Treeside Way, Berkeley, CA 94704   | 45       | 5     |
      | Pouring liquid    | Look, it changes colors     | 22-Apr-3019 | 422 Treeside Way, Berkeley, CA 94704   | 10       | 100   |
    And I am on the events page


  Scenario: browsing the events page in order
    Given I am on the events page
    Then 5 events should exist
    And I should see "Meet and greet" before "Heisenberg Talk"
    And I should not see "Beakers Quarterly"
