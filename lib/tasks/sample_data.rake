namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
		make_admin
  	make_doctors
		make_languages
		make_domains
		make_federal_holidays
	 	make_federal_holiday_dates
		make_doctors_languages
		make_doctors_domains
		make_patients
	end
	
	def make_admin
		admin = Admin.create!(name: "Admin User",
                 email: "admin.user@example.com",
                 password: "foobar",
                 password_confirmation: "foobar",
								 active: true)
  end

	def make_doctors
		99.times do |n|
      name  = Faker::Name.name
      email = "doctor-#{n+1}@gsad.com"
      password  = "password"
      Doctor.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
									 active: true )
    end
	end

	def make_languages
		Language.create!(name: "Chinese" )
		Language.create!(name: "English" )
		Language.create!(name: "Spanish" )
		Language.create!(name: "German" )
	end

	def make_domains
		Domain.create!(name: "Pediatrics")
		Domain.create!(name: "General practice")
		Domain.create!(name: "Dentistry")
		Domain.create!(name: "Optometry")
		Domain.create!(name: "Physiotherapy")
	end

	def make_federal_holidays
		FederalHoliday.create!(name: "New Year Day", chronic_pattern: "1st of january") 									#jan 1st
		FederalHoliday.create!(name: "Martin Luther King Day", chronic_pattern: "3rd monday in january")  #3rd monday, jan
		FederalHoliday.create!(name: "Presidents Day", chronic_pattern: "3rd monday in february") 				#3rd monday, feb
		FederalHoliday.create!(name: "Memorial Day", chronic_pattern: "last monday", base_date: "6.1") 		#final monday, may
		FederalHoliday.create!(name: "Independencey Day", chronic_pattern: "4th of july") 								#july 4th
		FederalHoliday.create!(name: "Labor Day", chronic_pattern: "1st monday in september") 						#1st monday, sep
		FederalHoliday.create!(name: "Columbus Day", chronic_pattern: "2nd monday in october") 						#2nd monday, oct
		FederalHoliday.create!(name: "Veterans Day", chronic_pattern: "11th of november") 								#nov 11th
		FederalHoliday.create!(name: "Thanksgiving Day", chronic_pattern: "4th thursday in november") 		#4th thursday, nov
		FederalHoliday.create!(name: "Christmas Day, Dec 25th", chronic_pattern: "25th of december") 			#dec 25th
		FederalHoliday.create!(name: "Christmas Day, Dec 26th", chronic_pattern: "26th of december") 			#dec 26th
	end

	def make_federal_holiday_dates
		FederalHoliday.all.each do |fh|
			(2013..2050).each do |year|
	  		date = Chronic.parse(fh.chronic_pattern, now: Time.utc(year, fh.base_date))
				FederalHolidayDate.create!(federal_holiday_id: fh.id, date: date)
			end
		end
	end

	def make_doctors_languages
		idx = 0
		Doctor.all.each do |doctor|
			doctor.languages << Language.find(idx%3+1)
		  if idx%3 != idx%4
				doctor.languages << Language.find(idx%4+1)
		  end
		  idx += 1
		end
  end

	def make_doctors_domains
		idx = 0
		Doctor.all.each do |doctor|
			doctor.domains << Domain.find(idx%4+1)
		  if idx%4 != idx%5 
				doctor.domains << Domain.find(idx%5+1)
		 	end
		  idx += 1
		end

	end

	def make_patients
		p = Patient.create!(name: "Patient User",
                 email: "patient@gsad.com",
                 password: "foobar",
                 password_confirmation: "foobar",
								 active: true)
		99.times do |n|
      name  = Faker::Name.name
      email = "patient-#{n+1}@gsad.com"
      password  = "password"
      Patient.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
									 active: true )
    end
	end

end
