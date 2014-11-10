require 'spec_helper'

describe Peep do 

	context 'Testing Database is working' do 

		it "Should create & retrieve peeps from database" do 
			expect(Peep.count).to eq 0
			Peep.create(content: 'Peep', user_id: 1)
			expect(Peep.count).to eq 1
			peep = Peep.first
			expect(peep.content).to eq 'Peep'
			peep.destroy
			expect(Peep.count).to eq 0
		end

	end

end

