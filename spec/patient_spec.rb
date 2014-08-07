require 'spec_helper'

describe 'Patient' do
  describe 'initialize' do
    it 'initializes a patient with a name, doctor id, and a birthdate' do
      test_patient = Patient.new({'name' => 'Vanilla Ice', 'birthdate' => '1975-01-15', 'doctor_id' => 1})
      expect(test_patient).to be_an_instance_of Patient
    end
  end
end
