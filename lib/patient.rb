class Patient

  attr_reader :name, :birthdate, :id

  def initialize(attributes)
    @name = attributes['name']
    @birthdate = attributes['birthdate']
    @id = attributes['id']
  end

  def self.all
    results = DB.exec("SELECT * FROM patient;")
    patients = []
    results.each do |result|
      name = result['name']
      birthdate = result['birthdate']
      id = result['id'].to_i
      patients << Patient.new({'name' => name, 'birthdate' => birthdate, 'id' => id})
    end
    patients
  end

  def save
    results = DB.exec("INSERT INTO patient (name, birthdate) VALUES ('#{@name}', '#{@birthdate}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(test)
    self.name == test.name && self.birthdate == test.birthdate
  end

  def update(new_information)
    @name = new_information['name']
    @birthdate = new_information['birthdate']
    DB.exec("UPDATE patient SET name = '#{@name}', birthdate = '#{@birthdate}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM patient WHERE id = #{@id}")
    DB.exec("DELETE FROM doctor_patient WHERE id = #{@id}")
  end

  def add_doctor(doc_id)
    DB.exec("INSERT INTO doctor_patient (doctor_id, patient_id) VALUES (#{doc_id}, #{@id})")
  end

  def doctors_list
    doctors = []
    results = DB.exec("SELECT doctor.* FROM patient JOIN doctor_patient ON (patient.id = doctor_patient.patient_id)
                      JOIN doctor ON (doctor_patient.doctor_id = doctor.id) WHERE patient.id = #{@id};")
    results.each do |result|
      id = result['id'].to_i
      name = result['name']
      doctors << Doctor.new({'name' => name, 'id' => id})
    end
    doctors
  end

  def self.find(patient_name)
    Patient.all.each do |patient|
      if patient.name == patient_name
        return patient
      end
    end
  end

end
