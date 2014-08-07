class Specialty

  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def self.all
    results = DB.exec("SELECT * FROM specialty;")
    specialties = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      specialties << Specialty.new({'name' => name, 'id' => id})
    end
    specialties
  end

  def save
    results = DB.exec("INSERT INTO specialty (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_specialty)
    self.name == another_specialty.name
  end

  def doctors
    results = DB.exec("SELECT * FROM doctor WHERE specialty_id = #{self.id};")
    doctors = []
    results.each do |result|
      name = result['name']
      specialty_id = result['specialty_id'].to_i
      id = result['id'].to_i
      doctors << Doctor.new({'name' => name, 'specialty_id' => specialty_id, 'id' => id})
    end
    doctors
  end

end
