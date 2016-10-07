# Completed step definitions for basic features: AddMovie, ViewDetails, EditMovie 

Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
 end


 When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', :with => title
  select rating, :from => 'Rating'
  click_button 'Save Changes'
 end

 Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating| 
   result=false
   all("tr").each do |tr|
     if tr.has_content?(title) && tr.has_content?(rating)
       result = true
       break
     end
   end  
  expect(result).to be_truthy
 end

 When /^I have visited the Details about "(.*?)" page$/ do |title|
   visit movies_path
   click_on "More about #{title}"
 end

 Then /^(?:|I )should see "([^"]*)"$/ do |text|
    expect(page).to have_content(text)
 end

 When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on "Edit"
  select rating, :from => 'Rating'
  click_button 'Update Movie Info'
 end


# New step definitions to be completed for HW5. 
# Note that you may need to add additional step definitions beyond these


# Add a declarative step here for populating the DB with movies.

Given /the following movies have been added to RottenPotatoes:/ do |movies_table|
  #pending  # Remove this statement when you finish implementing the test step
  movies_table.hashes.each do |movie|
    Movie.create(movie)    # Add the necessary Active Record call(s) to populate the database.
  end
end

When /^I have opted to see movies rated: "(.*?)"$/ do |arg1|
  # HINT: use String#split to split up the rating_list, then
  # iterate over the ratings and check/uncheck the ratings
  # using the appropriate Capybara command(s)
  #pending  #remove this statement after implementing the test step
  #puts arg1
  #puts arg1.split(', ') 
  
    Movie.all_ratings.each do |x|
        #puts "#{x}"
        uncheck("ratings_#{x}")
    end

    arg1.split(', ').each do |x|
        puts "Checked: #{x}"
        check("ratings_#{x}")
    end

    click_on "ratings_submit"
end

Then /^I should see only movies rated: "(.*?)"$/ do |arg1|
  #pending  #remove this statement after implementing the test step
    allratings = Movie.all_ratings
  
    displayratings=arg1.split(', ')
    puts displayratings
    
    displayratings.each do |rating|
        allratings.delete(rating)
    end
    puts allratings
    
     result = false
     all("tbody tr").each do |tr| #tbody removes headed column titles
         displayratings.each do |rating|
            puts tr.text 
            if tr.has_content?(rating)
              result = true
            else
              result = false
              break
            end
         end
    end 
  expect(result).to be_truthy
end

Then /^I should see all of the movies$/ do
  #pending  #remove this statement after implementing the test step
  result = false
  allMovies = Movie.all
  allMovies.each do |movie|
    count = 0
    all("tbody tr").each do |tr|  #tbody removes headed column titles
        #puts tr.text
        if tr.has_content?(movie.rating) && tr.has_content?(movie.title) && tr.has_content?(movie.release_date)
            puts movie.title
            #result = true
            count = 1
        end
    end
    if count != 0
        result = true
    else
        result = false
        return false
    end
  end
      
  expect(result).to be_truthy
end

When(/^I click Movie_Title Heading to sort by "(.*?)"$/) do |arg1|
  #pending # express the regexp above with the code you wish you had
  click_on arg1
end

Then(/^I should see "(.*?)" before "(.*?)"$/) do |arg1, arg2|
  #pending # express the regexp above with the code you wish you had
  result=false
  i = 0
  arg = Hash.new
  all("tbody tr").each do |tr|
      if tr.has_content?(arg1)
         arg[i] = arg1
         i = i + 1
      elsif tr.has_content?(arg2)
         arg[i] = arg2
         i = i + 1
      end
  end
  if(arg[0] == arg1 && arg[1] == arg2)
     result = true
  end
  
  puts arg
   
  expect(result).to be_truthy
end

When(/^I click Release_Date Heading to sort by "(.*?)"$/) do |arg1|
  #pending # express the regexp above with the code you wish you had
  click_on arg1
end

#Then(/^I should see "(.*?)" before "(.*?)"$/) do |arg1, arg2|
  #pending # express the regexp above with the code you wish you had
#end