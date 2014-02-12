# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :attachment do
		supporting_documentation_file_name { 'test.pdf' }
		supporting_documentation_content_type { 'application/pdf' }
		supporting_documentation_file_size { 1024 }
	end
end

FactoryGirl.define do
  factory :item do
    name "MyString"
    description "MyString"
    point 1
    image_path "MyString"
		image {} 
		branch 'someBranch'
  end
end
