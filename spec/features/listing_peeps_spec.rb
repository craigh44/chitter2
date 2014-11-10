require 'spec_helper'

	feature 'When visiting the home page' do

		scenario 'Should display a list of links' do
			sign_up("Craig", "Craig", "Craig", "Craig")
			Peep.create(:content => "Peep", :user_id => 1)
			visit '/'
			expect(page).to have_content 'Peep'
		end
		

			def sign_in(user_name, email, password)
		    visit '/sessions/new'
		    fill_in 'user_name', :with => user_name
		    fill_in 'email', :with => email
		    fill_in 'password', :with => password
		    click_button 'Sign in'
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