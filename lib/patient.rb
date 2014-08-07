class Patient

  attr_reader :name, :birthdate, :doctor_id, :id

  def initialize(attributes)
    @name = attributes['name']
    @birthdate = attributes['birthdate']
    @doctor_id = attributes['doctor_id']
    @id = attributes['id']
  end

  def self.all
    results = DB.exec("SELECT * FROM patient;")
    patients = []
    results.each do |result|
      name = result['name']
      birthdate = result['birthdate']
      doctor_id = result['doctor_id'].to_i
      id = result['id'].to_i
      patients << Patient.new({'name' => name, 'birthdate' => birthdate, 'doctor_id' => doctor_id, 'id' => id})
    end
    patients
  end

  def save
    results = DB.exec("INSERT INTO patient (name, birthdate, doctor_id) VALUES ('#{@name}', '#{@birthdate}', #{@doctor_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(test)
    self.name == test.name && self.birthdate == test.birthdate && self.doctor_id == test.doctor_id
  end

  def update_doctor(new_doctor_id)
    DB.exec("UPDATE patient SET doctor_id = #{new_doctor_id} WHERE id= #{@id};")
    @doctor_id = new_doctor_id
  end


end
