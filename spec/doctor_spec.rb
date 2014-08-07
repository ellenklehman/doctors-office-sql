require 'spec_helper'
require 'pry'

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

  it 'delets a doctors record' do
    test_doc = Doctor.new({'name' => 'Marty McFly', 'specialty_id' => 1, 'insurance_id' => 1, 'id' => 1})
    test_doc.save
    another_test_doc = Doctor.new({'name' => 'Dr. Seuss', 'specialty_id' => 2, 'insurance_id' => 2, 'id' => 2})
    another_test_doc.save
    test_doc.delete
    expect(Doctor.all).to eq [another_test_doc]
  end

end
