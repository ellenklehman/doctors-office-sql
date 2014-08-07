require 'spec_helper'

describe 'Patient' do
  describe 'initialize' do
    it 'initializes a patient with a name, doctor id, and a birthdate' do
      test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'doctor_id' => 1, 'id' => 1})
      expect(test_patient).to be_an_instance_of Patient
    end
  end

  it 'tells you its name, birthdate, doctor id and id' do
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'doctor_id' => 1, 'id' => 1})
    expect(test_patient.name).to eq 'Vanilla Ice'
    expect(test_patient.birthdate).to eq '1975-01-15'
    expect(test_patient.doctor_id).to eq 1
    expect(test_patient.id).to eq 1
  end

  it 'creates a place to hold all patient entries' do
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'doctor_id' => 1, 'id' => 1})
    expect(Patient.all).to eq []
  end

  it 'allows patients information to be saved' do
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'doctor_id' => 1, 'id' => 1})
    test_patient.save
    expect(Patient.all).to eq [test_patient]
  end

  it 'allows patients to update their doctor' do
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'doctor_id' => 1, 'id' => 1})
    test_patient.save
    test_doctor = Doctor.new({'name' => 'Dr. Dre', 'specialty_id' => 2, 'insurance_id' => 1})
    test_doctor.save
    test_patient.update_doctor(test_doctor.id)
    expect(test_patient.doctor_id).to eq test_doctor.id
  end
end
