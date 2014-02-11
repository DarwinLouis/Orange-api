require 'spec_helper'

describe Branch do
	it "should be a valid factory" do
		build(:branch).should be_valid
	end

	it 'stub geocode' do 
		Branch.any_instance.stubs(:geocode).returns([1,1])

		geo = create(:branch)

		geo.geocode.collect { |p| 
			p.should eql(1)
		}
	end

	it { should validate_presence_of(:name) }
	it { should validate_presence_of(:address) }
	it { should validate_presence_of(:latitude) }
	it { should validate_presence_of(:longitude) }
	it { should have_many(:promos) }
	

end
