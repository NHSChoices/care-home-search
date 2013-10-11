Feature: Postcode search
  Users can search for care providers in their local area by postcode

  Background:
    Given   you're on the home page

  Scenario: Searching for a postcode
    When    you search for your postcode
    Then    you're shown a list of nearby care homes

  Scenario: Leaving the postode field blank
    When    you do not enter a postcode
    Then    you're returned to the search form and informed of your error

  Scenario: Getting an error response from syndication
    When    you enter an invalid postcode
    Then    you're returned to the search form and told there was a problem

  Scenario: Viewing the results on a map
    Given   you're viewing the search results
    When    you click to view the map
    Then    the results are displayed on a map
