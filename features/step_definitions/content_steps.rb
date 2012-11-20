# Add a declarative step here for populating the DB with movies.

Given /the following articles exist/ do |articles_table|
  articles_table.hashes.each do |article|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    puts article["author"]
    puts article["title"]
    newarticle=Article.new
    newarticle.id=article["id"]
    newarticle.body=article["body"]
    newarticle.author=article["author"]
#newarticle.published=article["published"]
#    newarticle.permalink=article["permalink"]
    newarticle.title=article["title"]
    newarticle.type=article["type"]
    newarticle.save
    puts Article.find_by_title(article["title"])
  end
#flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert page.body.match /.*\b#{e1}\b.*\b#{e2}\b.*/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(",").each do |rating|
    if (uncheck)
      uncheck("ratings[" + rating.strip + "]")
    else
      check("ratings[" + rating.strip + "]")
    end
  end
end
# Make it easier to look ensure that all movies are displayed
Then /^I should see all movies$/ do 
  #  page.content  is the entire content of the page as a string.
  # check number of rows in the HTML table against the db.  Note that <tr> tag includes the header too
# so we need to add one to the count from the table
  assert_equal page.all('table#movies tr').count,Movie.count + 1 
end
#Check if director is updated on screen
Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |e1, e2|
  assert page.body.match /.*Details about #{e1}.*Director:.*#{e2}.*/m
end
