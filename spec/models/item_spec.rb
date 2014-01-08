require 'spec_helper'

describe Item do

	it "is a valid factory" do
		attachment = File.new(Rails.root + 'spec/fixtures/images/rails.png') 
		create(:item, image:attachment).should be_valid
	end

	it "is invalid without name" do
		build(:item, name: nil).should_not be_valid
	end
	
	it "is invalid without image" do
		build(:item, image: nil).should_not be_valid
	end

	it "is invalid without point" do
		build(:item, point: nil).should_not be_valid
	end

	it "is invalid without branch" do
		build(:item, branch: nil).should_not be_valid
	end

end
