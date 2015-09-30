# Add a declarative step here for populating the DB with movies.

ActiveRecord::Schema.define do
    drop_table :movies
    create_table :movies do |table|
        table.column :title, :string
        table.column :rating, :string
    table.column :release_date, :date
    end

end

class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
end

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  #fail "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  e1index = page.body.index(e1)
  e2index = page.body.index(e2)
  if e1index != nil
    e1index.should < e2index  
  end
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(",")
  ratings.each do |r|
    r = r.strip
    if uncheck == "un"
      uncheck("ratings_#{r}")
    else
      check("ratings_#{r}")
    end
  end
  #fail "Unimplemented"
end

Then /^I should see the following movies: (.*)/ do |films|
  films_a = films.split( "," )
  films_a.each do |film|
    f = film.strip
    step( "I should see #{f}" )
  end
end
Then /^I should not see the following movies: (.*)/ do |films|
  films_a = films.split( "," )
  films_a.each do |film|
    f = film.strip
    step( "I should not see #{f}" )
  end
end

Then(/^I should see all the movies$/) do
  # Make sure that all the movies in the app are visible in the table
  #assert(all("table#movies tr").count == Movie.all.count + 1)
  #page.all('table#movies tr').count.should == Movie.all.count + 1
  #rows = page.all("table#movies tbody tr td[1]").map! {|list| list.text}
  #assert ( rows.size == Movie.all.count )
  db_size = 0
  db_size = Movie.all.size
  page.find(:xpath, "//table[@id=\"movies\"]/tbody[count(tr) = #{db_size} ]")
  #fail "Unimplemented"
end

#G PG PG-13 NC-17 R

Given /^I uncheck all ratings/ do
   # pending # express the regexp above with the code you wish you had
  ratings = Array.new
  ratings.push( "G" );
  ratings.push( "PG" );
  ratings.push( "PG-13" );
  ratings.push( "NC-17" );
  ratings.push( "R" );
  ratings.each do |r|
    uncheck("ratings_#{r}")
  end
end

Given /^I check all ratings$/ do
  # pending # express the regexp above with the code you wish you had
  ratings = Array.new
  ratings.push( "G" );
  ratings.push( "PG" );
  ratings.push( "PG-13" );
  ratings.push( "NC-17" );
  ratings.push( "R" );
  ratings.each do |r|
    check("ratings_#{r}")
  end
end