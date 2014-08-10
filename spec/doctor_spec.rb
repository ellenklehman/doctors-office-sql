require 'spec_helper'

describe 'Doctor' do
  describe 'initialize' do
    it 'initializes a doctor with a name, specialty id and insurance id' do
      test_doc = Doctor.new({'name' => 'Marty McFly', 'specialty_id' => 1, 'insurance_id' => 1, 'id' => 1})
      expect(test_doc).to be_an_instance_of Doctor
    end
  end

  it 'tells you its name and id' do
    test_doc = Doctor.new({'name' => 'Marty McFly', 'specialty_id' => 1, 'insurance_id' => 1, 'id' => 1})
    expect(test_doc.name).to eq 'Marty McFly'
    expect(test_doc.id).to eq 1
  end

  it 'creates a place to hold all doctor entries' do
    test_doc = Doctor.new({'name' => 'Marty McFly', 'specialty_id' => 1, 'insurance_id' => 1, 'id' => 1})
    expect(Doctor.all).to eq []
  end

  it 'allows doctor entries to be saved' do
    test_doc = Doctor.new({'name' => 'Marty McFly', 'specialty_id' => 1, 'insurance_id' => 1, 'id' => 1})
    test_doc.save
    expect(Doctor.all).to eq [test_doc]
  end

  it 'allows a doctor to update their information' do
    test_doc = Doctor.new({'name' => 'Marty McFly', 'specialty_id' => 1, 'insurance_id' => 1, 'id' => 1})
    test_doc.save
    test_doc.update({'name' => 'Dr.Seuss', 'insurance_id' => 2})
    expect(test_doc.name).to eq 'Dr.Seuss'
    expect(test_doc.insurance_id).to eq 2
  end

  it 'deletes a doctors record' do
    test_doc = Doctor.new({'name' => 'Marty McFly', 'specialty_id' => 1, 'insurance_id' => 1, 'id' => 1})
    test_doc.save
    another_test_doc = Doctor.new({'name' => 'Dr. Seuss', 'specialty_id' => 2, 'insurance_id' => 2, 'id' => 2})
    another_test_doc.save
    test_doc.delete
    expect(Doctor.all).to eq [another_test_doc]
  end

  it 'returns a list of all doctors including the number of patients they see' do
    test_doc = Doctor.new({'name' => 'Marty McFly', 'specialty_id' => 1, 'insurance_id' => 1, 'id' => 1})
    test_doc.save
    another_test_doc = Doctor.new({'name' => 'Dr. Seuss', 'specialty_id' => 2, 'insurance_id' => 2, 'id' => 2})
    another_test_doc.save
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'doctor_id' => test_doc.id, 'id' => 1})
    test_patient.save
    another_test_patient = Patient.new({'name' => 'Chocolate Ice', 'birthdate' => '1986-05-31', 'doctor_id' => test_doc.id, 'id' => 2})
    another_test_patient.save
    yet_another_test_patient = Patient.new({'name' => 'Strawberry Ice', 'birthdate' => '1999-12-31', 'doctor_id' => another_test_doc.id, 'id' => 3})
    yet_another_test_patient.save
    test_patient.add_doctor(test_doc.id)
    another_test_patient.add_doctor(test_doc.id)
    yet_another_test_patient.add_doctor(another_test_doc.id)
    expect(Doctor.patient_count).to eq [[test_doc, 2], [another_test_doc, 1]]
  end

it 'assigns a patient to a doctor' do
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'id' => 1})
    test_patient.save
    test_doc = Doctor.new({'name' => 'Dr. Seuss', 'specialty_id' => 2, 'insurance_id' => 2, 'id' => 2})
    test_doc.save
    test_doc.add_patient(test_patient.id)
    expect(test_doc.patients_list).to eq [test_patient]
  end

  it 'stores and lists all of the patients associated with a doctor' do
    test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'id' => 1})
    test_patient.save
    test_doc = Doctor.new({'name' => 'Dr. Seuss', 'specialty_id' => 2, 'insurance_id' => 2, 'id' => 2})
    test_doc.save
    test_doc.add_patient(test_patient.id)
    expect(test_doc.patients_list).to eq [test_patient]
  end


end
