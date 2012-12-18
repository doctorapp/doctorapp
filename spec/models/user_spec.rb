require 'spec_helper'

describe User do

	before do
		@user = User.new(name: "cyrus zhang", email: "cyrus.ylzhang@gmail.com", password: "foobar", password_confirmation: "foobar", active: "true", user_type: "d" )
	end

	subject { @user } 

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:user_type) }		
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:active) }

	describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do 
    before {@user.email = " " }
    it { should_not be_valid }
  end 

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it { should_not be_valid }
  end
  
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end 

	describe "when user is active" do
		its(:active) { should be_true }
	end

	describe "when user is inactive" do
		before { @user.active = false }
		its(:active) { should_not be_true }
	end

	describe "user type" do
		describe "when user is doctor" do
			it "should be a doctor" do
				@user.doctor?.should be_true
				@user.office?.should be_false
				@user.patient?.should be_false
				@user.admin?.should be_false
			end
		end

		describe "when user is patient" do
			before { @user.user_type = 'p' }
			it "should be a patient" do
				@user.patient?.should be_true
				@user.admin?.should be_false
				@user.doctor?.should be_false
				@user.office?.should be_false
			end
		end

		describe "user cannot be of type other than d/o/p/a" do
			it "should not be valid" do
				(('a'..'z').to_a - ['a','d','o','p']).each do |user_type|
					@user.user_type = user_type
					@user.should_not be_valid
				end
			end
	 	end
	end

	
end
