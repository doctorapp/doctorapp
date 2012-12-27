require 'spec_helper'

describe FavoriteDoctor do

	let(:doctor) { FactoryGirl.create(:doctor) }
  let(:patient) { FactoryGirl.create(:patient) }
  let(:favorite_doctor) { patient.favorite_doctors.build(doctor_id: doctor.id) }

  subject { favorite_doctor }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to patient_id" do
      expect do
       	FavoriteDoctor.new(patient_id: patient.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

	describe "favorite methods" do    
    it { should respond_to(:doctor_id) }
    it { should respond_to(:patient_id) }
    its(:doctor_id) { should == doctor.id}
    its(:patient_id) { should == patient.id }
		its(:patient) { should == patient }
  end

	describe "when doctor id is not present" do
		before { favorite_doctor.doctor_id = nil }
		it { should_not be_valid }
	end

	describe "when patient id is not present" do
		before { favorite_doctor.patient_id = nil }
		it { should_not be_valid }
	end

end
