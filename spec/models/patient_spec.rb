require 'spec_helper.rb'

describe Patient do

	before do
		@patient = Patient.new(name: "paient 0", email: "p1@p.com", password: "foobar", password_confirmation: "foobar")
	end

	subject { @patient }

	it { should respond_to(:favorite_doctors) }
	it { should respond_to(:doctors) }
	it { should respond_to(:favorite!) }
	it { should respond_to(:favorite?) }
	it { should respond_to(:unfavorite!) }

	describe "favorite" do
		let(:doctor) { FactoryGirl.create(:doctor) }
		before do
			@patient.save
			@patient.favorite!(doctor)
		end

		it { should be_favorite(doctor) }
		its(:doctors) { should include(doctor) }

		describe "and unfavorite" do
			before { @patient.unfavorite!(doctor) }

			it { should_not be_favorite(doctor) }
			its(:doctors) { should_not include(doctor) }
		end

	end

end
