require 'spec_helper'

describe 'Specialty' do
  describe 'initialize' do
    it 'initializes a specialty with a name' do
      test_specialty = Specialty.new({'name' => 'Pediatrics', 'id' => 1})
      expect(test_specialty).to be_an_instance_of Specialty
    end
  end

  it 'tells you its name and id' do
    test_specialty = Specialty.new({'name' => 'Pediatrics', 'id' => 1})
    expect(test_specialty.name).to eq 'Pediatrics'
    expect(test_specialty.id).to eq 1
  end

  it 'creates a place to hold all specialty entries' do
    test_specialty = Specialty.new({'name' => 'Pediatrics', 'id' => 1})
    expect(Specialty.all).to eq []
  end

  it 'allows specialty information to be saved' do
    test_specialty = Specialty.new({'name' => 'Pediatrics', 'id' => 1})
    test_specialty.save
    expect(Specialty.all).to eq [test_specialty]
  end

  it 'lists out all doctors for a specific specialty' do
    test_specialty = Specialty.new({'name' => 'Pediatrics', 'id' => 1})
    test_specialty.save
    another_test_specialty = Specialty.new({'name' => 'General Practice', 'id' => 2})
    another_test_specialty.save
    test_doctor = Doctor.new({'name' => 'Dr. Dre', 'specialty_id' => test_specialty.id, 'insurance_id' => 1})
    test_doctor.save
    another_test_doctor = Doctor.new({'name' => 'Dr. Oz', 'specialty_id' => test_specialty.id, 'insurance_id' => 1})
    another_test_doctor.save
    yet_another_test_doctor = Doctor.new({'name' => 'Dr. Seuss', 'specialty_id' => test_specialty.id, 'insurance_id' => 1})
    yet_another_test_doctor.save
    expect(test_specialty.doctors).to eq [test_doctor, another_test_doctor, yet_another_test_doctor]
  end

  it 'updates specialty information' do
    test_specialty = Specialty.new({'name' => 'Pediatrics', 'id' => 1})
    test_specialty.save
    test_specialty.update({'name' => 'Podiatry'})
    expect(test_specialty.name).to eq 'Podiatry'
  end

  it 'deletes a specialty record' do
    test_specialty = Specialty.new({'name' => 'Pediatrics', 'id' => 1})
    test_specialty.save
    another_test_specialty = Specialty.new({'name' => 'General Practice', 'id' => 2})
    another_test_specialty.save
    test_specialty.delete
    expect(Specialty.all).to eq [another_test_specialty]
  end

end
