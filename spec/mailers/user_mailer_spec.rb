require "spec_helper"

describe UserMailer do

	let(:user) { FactoryGirl.create(:patient) }

  describe "password_reset" do
    let(:mail) { UserMailer.password_reset(user) }

		it "should have proper email" do
			user.email.should include("patient")
		end

    it "renders the headers" do
      mail.subject.should eq("Password reset")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
