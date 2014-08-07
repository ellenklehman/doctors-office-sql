require 'spec_helper'

describe 'Insurance' do
  describe 'initialize' do
    it 'initialize an insurance object with a name and id' do
      test_insurance = Insurance.new({'name' => 'Red Cross', 'id' => 1})
      expect(test_insurance).to be_an_instance_of Insurance
    end
  end

  it 'tells you its name and id' do
    test_insurance = Insurance.new({'name' => 'Red Cross', 'id' => 1})
    expect(test_insurance.name).to eq 'Red Cross'
    expect(test_insurance.id).to eq 1
  end

  it 'creates a place to hold all patient entries' do
    test_insurance = Insurance.new({'name' => 'Red Cross', 'id' => 1})
    expect(Insurance.all).to eq []
  end
end
