require 'spec_helper'

describe Device do
	it { should validate_presence_of(:key) }

	it { should validate_presence_of(:os_type) }
end
