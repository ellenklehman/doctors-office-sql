require 'spec_helper'

describe 'Insurance' do
  describe 'initialize' do
    it 'initialize an insurance object with a name' do
      test_insurance = Insurance.new({'name' => 'Red Cross'})
      expect(test_insurance).to be_an_instance_of Insurance
    end
  end
end
