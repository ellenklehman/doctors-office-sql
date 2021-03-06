require 'spec_helper'

describe 'Patient' do
  describe 'initialize' do
    it 'initializes a patient with a name, doctor id, and a birthdate' do
      test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'id' => 1})
      expect(test_patient).to be_an_instance_of Patient
    end
  end

  it 'tells you its name, birthdate, doctor id and id' do
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'id' => 1})
    expect(test_patient.name).to eq 'Vanilla Ice'
    expect(test_patient.birthdate).to eq '1975-01-15'
    expect(test_patient.id).to eq 1
  end

  it 'creates a place to hold all patient entries' do
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'id' => 1})
    expect(Patient.all).to eq []
  end

  it 'allows patients information to be saved' do
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'id' => 1})
    test_patient.save
    expect(Patient.all).to eq [test_patient]
  end

  it 'allows a patient to update their information' do
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'id' => 1})
    test_patient.save
    test_patient.update({'name' => 'The Artist formerly known as Vanilla Ice', 'birthdate' => '1967-10-31'})
    expect(test_patient.name).to eq 'The Artist formerly known as Vanilla Ice'
    expect(test_patient.birthdate).to eq '1967-10-31'
  end

  it 'deletes a patients record' do
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'id' => 1})
    test_patient.save
    another_test_patient = Patient.new({'name' => 'Chocolate Ice', 'birthdate' => '1986-05-31', 'id' => 1})
    another_test_patient.save
    test_patient.delete
    expect(Patient.all).to eq [another_test_patient]
  end

  it 'assigns a doctor to a patient' do
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'id' => 1})
    test_patient.save
    test_doc = Doctor.new({'name' => 'Dr. Seuss', 'specialty_id' => 2, 'insurance_id' => 2, 'id' => 2})
    test_doc.save
    test_patient.add_doctor(test_doc.id)
    expect(test_patient.doctors_list).to eq [test_doc]
  end

  it 'stores all of the doctors associated with a patient' do
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'id' => 1})
    test_patient.save
    test_doc = Doctor.new({'name' => 'Dr. Seuss', 'specialty_id' => 2, 'insurance_id' => 2, 'id' => 2})
    test_doc.save
    test_patient.add_doctor(test_doc.id)
    expect(test_patient.doctors_list).to eq [test_doc]
  end

  it 'finds a patients name and returns an instance of that patient' do
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'id' => 1})
    test_patient.save
    another_test_patient = Patient.new({'name' => 'Chocolate Ice', 'birthdate' => '1986-05-31', 'id' => 1})
    another_test_patient.save
    expect(Patient.find(test_patient.name)).to eq test_patient
  end

end
