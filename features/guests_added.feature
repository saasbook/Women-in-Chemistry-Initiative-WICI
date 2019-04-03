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

Scenario: click on "all guests"

Given I am on the guests page
When I follow "All Guests"
Then 4 guests should exist
Then I should see "Chris Pratt gotg@marvel.com Endgame"




