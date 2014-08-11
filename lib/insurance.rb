class Insurance

  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def self.all
    results = DB.exec("SELECT * FROM insurance;")
    insurances = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      insurances << Insurance.new({'name' => name, 'id' => id})
    end
    insurances
  end

  def save
    results = DB.exec("INSERT INTO insurance (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_insurance)
    self.name == another_insurance.name
  end

  def doctors
    results = DB.exec("SELECT * FROM doctor WHERE insurance_id = #{self.id};")
    doctors = []
    results.each do |result|
      name = result['name']
      insurance_id = result['insurance_id'].to_i
      specialty_id = result['specialty_id'].to_i
      id = result['id'].to_i
      doctors << Doctor.new({'name' => name, 'insurance_id' => insurance_id, 'specialty_id' => specialty_id, 'id' => id})
    end
    doctors
  end

  def update(new_information)
    @name = new_information['name']
    DB.exec("UPDATE insurance SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM insurance WHERE id = #{@id}")
    #add more functionality when join tables are added
  end

  def self.find(insurance_name)
    Insurance.all.each do |insurance|
      if insurance.name == insurance_name
        return insurance
      end
    end
  end
end
