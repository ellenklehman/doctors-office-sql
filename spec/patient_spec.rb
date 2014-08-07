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
end
