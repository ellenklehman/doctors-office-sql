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

  it 'allows a patient to update their information' do
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'doctor_id' => 1, 'id' => 1})
    test_patient.save
    test_patient.update({'name' => 'The Artist formerly known as Vanilla Ice', 'doctor_id' => 2, 'birthdate' => '1967-10-31'})
    expect(test_patient.name).to eq 'The Artist formerly known as Vanilla Ice'
    expect(test_patient.birthdate).to eq '1967-10-31'
    expect(test_patient.doctor_id).to eq 2
  end

  it 'deletes a patients record' do
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'doctor_id' => 1, 'id' => 1})
    test_patient.save
    another_test_patient = Patient.new({'name' => 'Chocolate Ice', 'birthdate' => '1986-05-31', 'doctor_id' => 1, 'id' => 1})
    another_test_patient.save
    test_patient.delete
    expect(Patient.all).to eq [another_test_patient]
  end
end
