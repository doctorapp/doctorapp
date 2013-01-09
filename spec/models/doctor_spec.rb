require 'spec_helper'

describe User do

	before do
		@doctor = Doctor.new(name: "cyrus zhang", email: "cyrus.ylzhang@gmail.com", password: "foobar", password_confirmation: "foobar", active: "true" )
	end

	subject { @doctor } 

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:type) }		
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:active) }
	its(:type) { should == "Doctor" }  # auto initialized to be "Doctor" type
	it { should respond_to(:work_days) }

	describe "access work_days" do

		before { @doctor.work_days.monday = true }
		
		it { should be_valid}

	end


end
