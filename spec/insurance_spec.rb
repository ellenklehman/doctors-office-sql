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

  it 'creates a place to hold all insurance entries' do
    test_insurance = Insurance.new({'name' => 'Red Cross', 'id' => 1})
    expect(Insurance.all).to eq []
  end

  it 'allows insurance information to be saved' do
    test_insurance = Insurance.new({'name' => 'Red Cross', 'id' => 1})
    test_insurance.save
    expect(Insurance.all).to eq [test_insurance]
  end

  it 'allows insurance information to be updated' do
    test_insurance = Insurance.new({'name' => 'Red Cross', 'id' => 1})
    test_insurance.save
    test_insurance.update({'name' => 'Health Shield'})
    expect(test_insurance.name).to eq 'Health Shield'
  end

  it 'deletes an insurance record' do
    test_insurance = Insurance.new({'name' => 'Red Cross', 'id' => 1})
    test_insurance.save
    another_test_insurance = Insurance.new({'name' => 'Health Shield', 'id' => 2})
    another_test_insurance.save
    another_test_insurance.delete
    expect(Insurance.all).to eq [test_insurance]
  end

  it 'finds a insurance providers name and returns an instance of that provider' do
    test_insurance = Insurance.new({'name' => 'Red Cross', 'id' => 1})
    test_insurance.save
    another_test_insurance = Insurance.new({'name' => 'Health Shield', 'id' => 2})
    another_test_insurance.save
    expect(Insurance.find(test_insurance.name)).to eq test_insurance
  end

end
