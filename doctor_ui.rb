require './lib/doctor'
require './lib/patient'
require './lib/insurance'
require './lib/specialty'
require 'pg'

DB = PG.connect({:dbname => 'doctors_office'})

def main_menu
	system('clear')
	loop do
		puts "Welcome to the Doctor's office!\n\n"
		puts "Type 'd' to access the doctor files"
		puts "Type 'p' to access the patient files"
		puts "Type 's' to access the specialty files"
		puts "Type 'i' to access the insurance provider files"
		puts "Type 'c' to clear the database of all files"
		puts "Type 'x' to exit"

		user_choice = gets.chomp.downcase

		case user_choice
			when 'd'
				doctor
			when 'p'
				patient
			when 's'
				specialty
			when 'i'
				insurance
			when 'c'
				clear_files
			when 'x'
				puts "Goodbye!\n"
				exit
			else
				puts "Please enter a valid option"
		end
	end
end

def doctor
	system('clear')
	loop do
		puts "Welcome to the doctor files"
		puts "Type 'a' to create a new doctor file"
		puts "Type 'l' to see a list of all of the doctors at this practice and to access a specific doctor's files"
		puts "Type 'p' to see a list of all of the doctors with the number of patients they see"
		puts "Type 'm' to return to the main_menu"

		user_choice = gets.chomp.downcase

		case user_choice
			when 'a'
				create_doctor
			when 'l'
				list_doctors
			when 'p'
				Doctor.patient_count.each do |doctor|
					puts "#{doctor[0].name} patient count: #{doctor[1]}"
				end
			when 'm'
				main_menu
			else
				puts "Please choose a valid option"
		end
	end
end

def create_doctor
	puts "What is the doctor's name?"
	new_name = gets.chomp.downcase
	puts "What insurance does the doctor accept?"
	new_insurance = gets.chomp.downcase
	insurance = Insurance.find(new_insurance)
	puts "What is the doctor's specialty?"
	new_specialty = gets.chomp.downcase
	specialty = Specialty.find(new_specialty)
	new_doctor = Doctor.new({'name' => new_name, 'insurance_id' => insurance.id, 'specialty_id' => specialty.id})
	new_doctor.save
	doctor
end

def list_doctors
	system('clear')
	loop do
		if Doctor.all.empty?
			puts "There are no doctors added yet!"
			sleep(2)
			doctor
		end
		Doctor.all.each do |doctor|
			puts "#{doctor.name}"
		end
		puts "Type in the name of the doctor's files you would like to access/update"
		doctor_name = gets.chomp.downcase
		current_doctor = Doctor.find(doctor_name)
		puts "What would you like to do with #{current_doctor.name}'s file?"
		puts "Type 'u' to update their file"
		puts "Type 'd' to delete their file"
		puts "Type 'a' to assign a patient to this doctor"
		puts "Type 'l' to list all of the patients under this doctor's care"
		puts "Type 'm' to return to the doctor menu"
		user_choice = gets.chomp.downcase

		case user_choice
			when 'u'
				update_doctor(current_doctor)
			when 'd'
				current_doctor.delete
			when 'a'
				assign_patient(current_doctor)
			when 'l'
				results = current_doctor.patients_list
				results.each do |patient|
					puts patient.name
				end
			when 'm'
				doctor
			else
				puts "Please type a valid option"
		end
	end
end

def update_doctor(current_doctor)
	system('clear')
	loop do
		puts "Type 'n' to update the name of #{current_doctor.name}"
		puts "Type 's' to update the specialty of #{current_doctor.name}"
		puts "Type 'i' to update the insurance of #{current_doctor.name}"
		puts "Type 'm' to return to the doctor's menu"
		user_choice = gets.chomp.downcase

		case user_choice
		when 'n'
			puts "What is the new name of the doctor?"
			new_name = gets.chomp.downcase
			current_doctor.update({'name' => new_name})
		when 's'
			puts "What is this doctor's new specialty?"
			new_specialty = gets.chomp.downcase
			specialty = Specialty.find(new_specialty)
			current_doctor.update({'specialty_id' => specialty.id})
		when 'i'
			puts "What is this doctor's new insurance?"
			new_insurance = gets.chomp.downcase
			insurance = Insurance.find(new_insurance)
			current_doctor.update({'insurance_id' => insurance.id})
		when 'm'
			doctor
		else
			Puts "Please type a valid option"
		end
	end
end

def assign_patient(current_doctor)
	puts "What is the patient's name that you would like to add to #{current_doctor.name}?"
	patient_name = gets.chomp.downcase
	patient = Patient.find(patient_name)
	current_doctor.add_patient(patient.id)
	doctor
end

def patient
	system('clear')
	puts "Welcome to the patient files"
	puts "Type 'a' to create a new patient file"
	puts "Type 'l' to see a list of all of the patients at this practice and to access a specific patient's files"
	puts "Type 'm' to return to the main_menu"

	user_choice = gets.chomp.downcase

	case user_choice
		when 'a'
			create_patient
		when 'l'
			list_patients
		when 'm'
			main_menu
		else
			puts "Please choose a valid option"
	end
	patient
end

def create_patient
	puts "What is the patient's name?"
	new_name = gets.chomp.downcase
	puts "What is the patient's birthdate? Please use YYYY-MM-DD format."
	new_birthdate = gets.chomp.downcase
	new_patient = Patient.new({'name' => new_name, 'birthdate' => new_birthdate})
	new_patient.save
	patient
end

def list_patients
	system('clear')
	loop do
		if Patient.all.empty?
			puts "There are no patients added yet!"
			sleep(2)
			patient
		end
		Patient.all.each do |patient|
			puts "#{patient.name}"
		end
		puts "Type in the name of the patient's files you would like to access/update"
		patient_name = gets.chomp.downcase
		current_patient = Patient.find(patient_name)
		puts "What would you like to do with that #{current_patient.name}'s file?"
		puts "Type 'u' to update their file"
		puts "Type 'd' to delete their file"
		puts "Type 'a' to assign a doctor to this patient"
		puts "Type 'l' to list all of the doctors treating this patient"
		puts "Type 'm' to return to the patient menu"
		user_choice = gets.chomp.downcase

		case user_choice
			when 'u'
				update_patient(current_patient)
			when 'd'
				current_patient.delete
			when 'a'
				assign_doctor(current_patient)
			when 'l'
				results = current_patient.doctors_list
				results.each do |doctor|
					puts doctor.name
				end
			when 'm'
				patient
			else
				puts "Please type a valid option"
		end
	end
	patient
end

def update_patient(current_patient)
	system('clear')
	loop do
		puts "Type 'n' to update the name of the patient"
		puts "Type 'b' to update the birthdate"
		puts "Type 'm' to return to the patient's menu"
		user_choice = gets.chomp.downcase

		case user_choice
		when 'n'
			puts "What is the new name of the patient?"
			new_name = gets.chomp.downcase
			current_patient.update({'name' => new_name})
		when 'b'
			puts "What is this patient's actual birthdate?"
			new_birthdate = gets.chomp
			current_patient.update({'birthdate' => new_birthdate})
		when 'm'
			patient
		else
			puts "Please type a valid option"
		end
	end
	patient
end

def assign_doctor(current_patient)
	puts "What is the doctor's name that you would like to add to #{current_patient.name}'s file?"
	doctor_name = gets.chomp.downcase
	doctor = Doctor.find(doctor_name)
	current_patient.add_doctor(doctor.id)
	patient
end

def specialty
	system('clear')
	puts "Welcome to the specialty files"
	puts "Type 'a' to create a new specialty file"
	puts "Type 'l' to see a list of all of the specialties at this practice and to access a specific file"
	puts "Type 'm' to return to the main_menu"

	user_choice = gets.chomp.downcase

	case user_choice
		when 'a'
			create_specialty
		when 'l'
			list_specialty
		when 'm'
			main_menu
		else
			puts "Please choose a valid option"
	end
	specialty
end

def create_specialty
	puts "What is the specialty name?"
	new_name = gets.chomp.downcase
	new_specialty = Specialty.new({'name' => new_name})
	new_specialty.save
	specialty
end

def list_specialty
	system('clear')
	loop do
		if Specialty.all.empty?
			puts "There are no specialties added yet!"
			sleep(2)
			specialty
		end
		Specialty.all.each do |specialty|
			puts "#{specialty.name}"
		end
		puts "Type in the name of the specialty to access/update those files"
		specialty_name = gets.chomp.downcase
		current_specialty = Specialty.find(specialty_name)
		puts "What would you like to do with that #{current_specialty.name}'s file?"
		puts "Type 'u' to update the file"
		puts "Type 'd' to delete the file"
		puts "Type 'l' to list all of the doctors with this specialty"
		puts "Type 'm' to return to the specialty menu"
		user_choice = gets.chomp.downcase

		case user_choice
			when 'u'
				update_specialty(current_specialty)
			when 'd'
				current_specialty.delete
			when 'l'
				results = current_specialty.doctors
				results.each do |result|
					puts result.name
				end
			when 'm'
				specialty
			else
				puts "Please type a valid option"
		end
	end
	specialty
end

def update_specialty(current_specialty)
	puts "What is the new name of the specialty?"
	new_name = gets.chomp.downcase
	current_specialty.update({'name' => new_name})
	specialty
end

def insurance
	system('clear')
	puts "Welcome to the insurance files"
	puts "Type 'a' to create a new insurance file"
	puts "Type 'l' to see a list of all of the insurance providers we use and to access a specific file"
	puts "Type 'm' to return to the main_menu"

	user_choice = gets.chomp.downcase

	case user_choice
		when 'a'
			create_insurance
		when 'l'
			list_insurance
		when 'm'
			main_menu
		else
			puts "Please choose a valid option"
	end
	insurance
end

def create_insurance
	puts "What is the insurance provider's name?"
	new_name = gets.chomp.downcase
	new_insurance = Insurance.new({'name' => new_name})
	new_insurance.save
	insurance
end

def list_insurance
	system('clear')
	loop do
		if Insurance.all.empty?
			puts "There are no insurance providers added yet!"
			sleep(2)
			insurance
		end
		Insurance.all.each do |insurance|
			puts "#{insurance.name}"
		end
		puts "Type in the name of the insurance provider to access/update those files"
		insurance_name = gets.chomp.downcase
		current_insurance = Insurance.find(insurance_name)
		puts "What would you like to do with #{current_insurance.name}'s file?"
		puts "Type 'u' to update the file"
		puts "Type 'd' to delete the file"
		puts "Type 'l' to list all of the doctors with this insurance"
		puts "Type 'm' to return to the insurance menu"
		user_choice = gets.chomp.downcase

		case user_choice
			when 'u'
				update_insurance(current_insurance)
			when 'd'
				current_insurance.delete
			when 'l'
				results = current_insurance.doctors
				results.each do |result|
					puts result.name
				end
			when 'm'
				insurance
			else
				puts "Please type a valid option"
		end
	end
	insurance
end

def update_insurance(current_insurance)
	puts "What is the new name of the insurance provider?"
	new_name = gets.chomp.downcase
	current_insurance.update({'name' => new_name})
	insurance
end

def clear_files
	system('clear')
	puts "Are you sure you want to clear all files from this database? Y/N"
	user_choice = gets.chomp.downcase
	if user_choice == 'y'
    DB.exec("DELETE FROM doctor *;")
    DB.exec("DELETE FROM patient *;")
    DB.exec("DELETE FROM specialty *;")
    DB.exec("DELETE FROM insurance *;")
    DB.exec("DELETE FROM doctor_patient *;")
   else
   	main_menu
   end
end

main_menu
