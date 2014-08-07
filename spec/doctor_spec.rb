require 'spec_helper'

describe 'Doctor' do
  describe 'initialize' do
    it 'initializes a doctor with a name and id' do
      test_doc = Doctor.new({'name' => 'Marty McFly', 'id' => 1})
      expect(test_doc).to be_an_instance_of Doctor
    end
  end

  it 'tells you its name and id' do
    test_doc = Doctor.new({'name' => 'Marty McFly', 'id' => 1})
    expect(test_doc.name).to eq 'Marty McFly'
    expect(test_doc.id).to eq 1
  end

  it 'creates a place to hold all doctor entries' do
    test_doc = Doctor.new({'name' => 'Marty McFly', 'id' => 1})
    expect(Doctor.all).to eq []
  end
end
