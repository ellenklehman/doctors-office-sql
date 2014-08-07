class Doctor

  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def self.all
    results = DB.exec("SELECT * FROM doctor;")
    doctors = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      doctors << Doctor.new({'name' => name, 'id' => id})
    end
    doctors
  end

  def save
    results = DB.exec("INSERT INTO doctor (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(test)
    self.name == test.name
  end

end
