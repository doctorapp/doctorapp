class Search < ActiveRecord::Base
  attr_accessible :domain_id, :end, :language_id, :post_code, :start
  def doctors
    @doctors ||= find_doctors
    #@appointments ||= @doctors.appointments
  end
  
  def appointments
  	appointmentsList = Doctor.find(205).appointments.where("end > ?", Time.now).order("start desc") 

  	#appointmentsList =  Appointment.all;
  	doctors = self.doctors

  	for doctor in doctors
  		@appointmentsForDoctor = doctor.appointments.where("end > ?", Time.now).order("start desc") 
  		
  		#timeslotList.push(doctor.appointments.where("start > ? ", start) )
  		#appointmentsList.push(doctor.appointments)
  	end

	appointmentsList
  	#@appointmentsList.where("1=1");
  end

  def available_slots
  	@appointmentsList = self.appointments




  end

private
  def find_doctors
    doctors = Doctor.order(:name)
    domain = Domain.find(domain_id) if domain_id.present?
    language = Language.find(language_id) if language_id.present?
    office = Office.where(:post_code => post_code ) if post_code.present?

    doctors1 = domain.doctors
    doctors2 = language.doctors
    
    doctors = doctors2 & doctors1

    #residence = 

    #doctors = doctors.where("name like ?", "%doctor%") 
    #domains = DoctorDomain.where(domain_id: domain_id).doctor_ids
    #doctors = doctors.domains.
    #doctors = doctors.where(domain_id: domain_id) if domain_id.present?
    #doctors = doctors.where(language_id: language_id) if language_id.present?
    #doctors = products.where(category_id: category_id) if category_id.present?
    #doctors = products.where("price >= ?", min_price) if min_price.present?
    #doctors = products.where("price <= ?", max_price) if max_price.present?
    doctors
  end
end
