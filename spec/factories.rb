FactoryGirl.define do
  factory :doctor do
    sequence(:name)  { |n| "Doctor #{n}" }
    sequence(:email) { |n| "doctor_#{n}@example.com" }   
    password "foobar"
    password_confirmation "foobar"
  end

	factory :patient do
		sequence(:name)  { |n| "Patient #{n}" }
		sequence(:email) { |n| "patient_#{n}@example.com" }
		password "foobar"
		password_confirmation "foobar"
	end

end
