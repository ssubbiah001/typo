Feature: Create Blog
  As an admin
  In order to organize the blogs effectively for the users
  I want to create a merge capability

  Background:
    Given the blog is set up
    And the following articles exist:
    |author|body|id|type|permalink|published|title|
    |Masteroe|This is a test blog1.|3|Article|test_blog1|true|test_blog1|
    |jdoe|This is a test blog2.|4|Article|test_blog2|true|test_blog2|

  Scenario: Admins can see the Merge form on Edit page
    When I am logged into the admin panel
    And I am on the edit article page for 3
    Then I should see "Merge Articles"

  Scenario: Admins cannot see the Merge form on New page
    When I am logged into the admin panel
    And I am on the new article page
    Then I should not see "Merge Articles"

  Scenario: Non Admins cannot see the Merge form on any page
    When I am logged in as "jdoe"
    And I am on the edit article page for 4
    Then I should not see "Merge Articles"

  Scenario: Merge article merges articles
    When I am logged into the admin panel
    And I am on the edit article page for 3
    When I fill in "merge_with" with "4"
    And I press "Merge"
    Then I should be on the home page
