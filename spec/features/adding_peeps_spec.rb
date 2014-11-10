require 'spec_helper'

	feature 'When on homepage' do

	User.create(:user_name => 'test',
    						:email => "test@test.com",
                :password => 'test',
                :password_confirmation => 'test') 

		scenario 'user should be able to peep' do 
			visit '/'
			Peep.create('Peep')
			expect(Peep.count).to eq 1
			peep = Peep.first
			expect(peep.content).to eq 'Peep'
		end

		def add_peep(content)
			within("#new-peep") do 
			fill_in 'content', :with => content
      click_button 'Peep'
    end

	end

end