Feature: Result view
  Users can view more information about a specific care provider.

  Background:
    Given   you're viewing the search results

  Scenario: Going to the result view
    When    you click on the "Read more about..." link
    Then    you are taken to the results view for that provider
