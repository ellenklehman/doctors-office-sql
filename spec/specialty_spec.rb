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
end
