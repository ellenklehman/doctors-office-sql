require 'spec_helper'

describe 'Specialty' do
  describe 'initialize' do
    it 'initializes a specialty with a name' do
      test_specialty = Specialty.new({'name' => 'Pediatrics'})
      expect(test_specialty).to be_an_instance_of Specialty
    end
  end
end
