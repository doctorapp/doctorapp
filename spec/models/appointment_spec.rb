require 'spec_helper'

describe Appointment do

	let(:doctor) { FactoryGirl.create(:doctor) }
	let(:patient) { FactoryGirl.create(:patient) }
	
	before do
		@app = Appointment.new(doctor_id: doctor.id, patient_id: patient.id, title: "new appointment", start: '02 NOV 2012', end: '02 NOV 2012', allday: true) 
		@app.save
	end

	subject {@app}

	it { should respond_to(:doctor_id) }
	it { should respond_to(:patient_id) }
	it { should respond_to(:title) }
	it { should respond_to(:start) }
	it { should respond_to(:end) }
	it { should respond_to(:allday) }
	its(:doctor_id) { should == doctor.id }
	its(:patient_id) { should == patient.id }

	it "doctor should have the appointment" do
		doctor.appointments.should include(@app)
	end

	it "patient should have the appointment" do
		patient.appointments.should include(@app)
	end

end
