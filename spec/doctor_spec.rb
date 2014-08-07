require 'spec_helper'

describe 'Doctor' do
  describe 'initialize' do
    it 'initializes a doctor with a name' do
      test_doc = Doctor.new({'name' => 'Marty McFly'})
      expect(test_doc).to be_an_instance_of Doctor
    end
  end
end
