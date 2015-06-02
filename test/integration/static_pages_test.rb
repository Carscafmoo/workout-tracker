require 'test_helper'

class StaticPagesTest < ActionDispatch::IntegrationTest
  ## Each page should test the following:
  # From the homepage, are the links available?
  # When you get that link, does it take you where you want to go?
  
  test "Homepage has all the links" do 
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2 # There's a 'home' link and the logo
    assert_select "a[href=?", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  end

  test "Help path redirects to DNE" do 
    get help_path
    assert_template 'static_pages/help'
    assert_match 'This functionality does not yet exist', response.body
    assert_select 'a[href=?]', contact_path, count: 2
  end

  test "About path works" do 
    get about_path
    assert_template 'static_pages/about'
    assert_match 'This site is currently under construction', response.body
  end

  test "Contact path works" do 
    get contact_path
    assert_template 'static_pages/contact'
    assert_match 'Carson C Moore, LLC', response.body
    assert_select "a[href=?]", "http://www.carscafmoo.com"
    assert_select "a[href=?]", "https://github.com/Carscafmoo/workout-tracker"
  end

end