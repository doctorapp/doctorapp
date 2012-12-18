require 'spec_helper'

describe "StaticPages" do
	
	it "should have content" do 
		visit root_path
		page.should have_content("Doctor app")
	end

end
