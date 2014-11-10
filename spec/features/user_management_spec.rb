require 'spec_helper'

feature 'User signs up' do 

		scenario 'When being logged out' do 
			expect { sign_up }.to change(User, :count).by 1
			expect(page).to have_content("Welcome, Craig")
		end

		scenario 'When user enters password confirmation wrong' do
			expect { sign_up('user', 'email', 'pass', 'wrong') }.to change(User, :count).by 0
			expect(current_path).to eq('/users/new')
      expect(page).to have_content("Password does not match the confirmation")
		end

		scenario "with an email that is already registered" do
	    expect{ sign_up }.to change(User, :count).by(1)
	    expect{ sign_up }.to change(User, :count).by(0)
	    expect(page).to have_content("This email is already taken")
  	end

		def sign_up(user_name = "Craig",
								email = 'craighorsborough@gmail.com',
								password = 'makers',
								password_confirmation = 'makers') 
				visit 'users/new'
				within('#sign_up') do 
				fill_in 'user_name', :with => user_name
				fill_in 'email', :with => email
				fill_in 'password', :with => password
				fill_in 'password_confirmation', :with => password_confirmation
				click_button 'Sign Up'
		end

	end

end






feature "User signs in" do

  before(:each) do
    User.create(:user_name => 'test',
    						:email => "test@test.com",
                :password => 'test',
                :password_confirmation => 'test')
  end

  scenario "with correct credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, test")
    sign_in('test', 'test@test.com', 'test')
    expect(page).to have_content("Welcome, test")
  end

  scenario "with incorrect credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, test")
    sign_in('test', 'test@test.com', 'wrong')
    expect(page).not_to have_content("Welcome, test")
  end

  def sign_in(user_name, email, password)
    visit '/sessions/new'
    fill_in 'user_name', :with => user_name
    fill_in 'email', :with => email
    fill_in 'password', :with => password
    click_button 'Sign in'
  end

end




feature 'User signs out' do

  before(:each) do
    User.create(:user_name => 'test',
                :email => "test@test.com",
                :password => 'test',
                :password_confirmation => 'test')
  end

  scenario 'while being signed in' do
    sign_in('test', 'test@test.com', 'test')
    click_button "Sign out"
    expect(page).to have_content("Good bye!")
    expect(page).not_to have_content("Welcome, test")
  end

  
  def sign_in(user_name, email, password)
    visit '/sessions/new'
    fill_in 'user_name', :with => user_name
    fill_in 'email', :with => email
    fill_in 'password', :with => password
    click_button 'Sign in'
  end

end