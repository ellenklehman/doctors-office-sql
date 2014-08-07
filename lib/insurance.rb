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

end
