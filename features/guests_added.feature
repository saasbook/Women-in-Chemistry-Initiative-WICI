Feature: See if you are attening an event

As a visitor to the website
So that I can see if my name was registered to an event
I want to be able to click to see who is going to an event

Background:

Given the following guests exist:

	  | firstname| lastname| email                      | event      |
	  | me       | you     | her@him.com                | us         |
	  | Nickel   | Dime    | money@cash.net             | gold nugget|
	  | Chris    | Pratt   | gotg@marvel.com            | Endgame    |
	  | Player1  | Player2 | xbox1234567890@numerics.net| testing    |

Given the following events exist:
      | name              | description                 | date        | location                               | tickets               |
      | Drinking          | Come drink with us          | 25-Nov-2018 | A bar                                  | tinyurl.com/tickets   |
      | Heisenberg Talk   | Is this reference dated yet | 26-Mar-2019 | 456 Wantabo Blvd, New Mexico, AZ 94704 | amc.com/breakingbad   |
      | Beakers Quarterly | To beak or not to beak      | 20-Apr-2019 | 8888 Haste St, Berkeley, CA 94704      | beakers.com/wici      |
      | Meet and greet    | Meet your favorite chemists | 26-Feb-2019 | 123 Treeside Way, Berkeley, CA 94704   | stubhub.com/chemistry |
      | Pouring liquid    | Look, it changes colors     | 22-Apr-2019 | 422 Treeside Way, Berkeley, CA 94704   | stubhub.com/liquid    |

Scenario: click on "all guests"

Given I am on the guests page
When I follow "All Guests"
Then 4 guests should exist
Then I should see "Chris Pratt gotg@marvel.com Endgame"

Given I am on the guests page
Then I should see "Drinking"
Then I should see "Heisenberg Talk"




