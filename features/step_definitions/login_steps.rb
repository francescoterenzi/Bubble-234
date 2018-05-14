When /^I log in$/ do
  if @user == nil
    login('test@test.com','test')
  else
    @current_user = @user
    login(@user.email, 'testtest')
  end
end

When /^I log in as (.*)$/ do |email|
  @user = User.find_by(email: email)
  @current_user = @user
  login(@user.email, 'testtest')
end

When /^I register as (.+), (.+)$/ do |email, password|
  register(email, password)
end

Given /^I am signed in with (.*) provider$/ do |provider|
  visit "/users/auth/#{provider.downcase}"
end

When /^I sign in with (.*) provider$/ do |provider|
  visit "/users/auth/#{provider.downcase}"
end

Given /^I am a registered user$/ do
  @user = User.create!(:first_name => 'test', :last_name => 'user', :email => 'test@test.com', :username => 'test',:password => 'testtest', :password_confirmation => 'testtest')
end

Given /^another user exists$/ do
  @user = User.create!(:first_name => 'fake', :last_name => 'fake', :email => 'fake@user.com', :username => 'test',:password => 'testtest', :password_confirmation => 'testtest')
end

Given /^another user called (.*) exists$/ do |user|
  @user = User.create!(:first_name => user, :last_name => user, :email => user, :username => user,:password => 'testtest', :password_confirmation => 'testtest')
end

When /^I press Delete button$/ do
  visit('/admin/users/0/delete')
end

When /^I press "Yes, I'm sure" button$/ do
  element = find_by_id('edit_user_0')
  Capybara::RackTest::Form.new(page.driver, element.native).submit
end

Given /^I am not a registered user$/ do
  @user = nil
end

Given /^I am a logged in user$/ do
  @user = User.create!(id: 100, :first_name => 'test', :last_name => 'test', :email => 'test@test.com', :username => 'test',:password => 'testtest')
  @current_user = @user
  login(@user.email, @user.password)
end

Given /^I am a logged in admin user$/ do
  @user = User.create!(id: 100, :first_name => 'test', :last_name => 'test',admin: true, :username => 'test',:email => 'test@test.com', :password => 'testtest')
  @current_user = @user
  login(@user.email, @user.password)
end

Given /^I was previously logged in as (.*)$/ do |user|
  @user = User.create!(id: 101, :first_name => user, :last_name => user, :email => user, :password => 'testtest')
  login(@user.email, @user.password)
  visit(destroy_user_session_path)
end

Given /^I am not authenticated$/ do
  visit destroy_user_session_path  # ensure that at least
end

module LoginSteps
  def login(email, password)
    visit(new_user_session_path)
    fill_in('Login', :with => email)
    fill_in('Password', :with => password)
    click_button('Log In')
  end
  def register(email, password)
    visit(new_user_registration_path)
    fill_in('First name', :with => email)
    fill_in('Last name', :with => email)
    fill_in('Email', :with => email)
    fill_in('Username', :with => password)
    fill_in('Password', :with => password)
    fill_in('Password confirmation', :with => password)
    click_button('Sign Up')
  end
end

World(LoginSteps)
