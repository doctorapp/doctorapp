namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
		make_admin
  	make_doctors
		make_languages
		make_domains
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
