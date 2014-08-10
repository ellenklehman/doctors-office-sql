class Doctor

  attr_reader :name, :specialty_id, :insurance_id, :id

  def initialize(attributes)
    @name = attributes['name']
    @specialty_id = attributes['specialty_id']
    @insurance_id = attributes['insurance_id']
    @id = attributes['id']
  end

  def self.all
    results = DB.exec("SELECT * FROM doctor;")
    doctors = []
    results.each do |result|
      name = result['name']
      specialty_id = result['specialty_id'].to_i
      insurance_id = result['insurance_id'].to_i
      id = result['id'].to_i
      doctors << Doctor.new({'name' => name, 'specialty_id' => specialty_id, 'insurance_id' => insurance_id, 'id' => id})
    end
    doctors
  end

  def save
    results = DB.exec("INSERT INTO doctor (name, specialty_id, insurance_id) VALUES ('#{@name}', #{@specialty_id}, #{@insurance_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(test)
    self.name == test.name
  end

  def update(new_information)
    @name = new_information['name']
    @insurance_id = new_information['insurance_id'].to_i
    @specialty_id = new_information['specialty_id'].to_i
    DB.exec("UPDATE doctor SET name = '#{@name}', insurance_id = #{@insurance_id}, specialty_id = #{@specialty_id} WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM doctor WHERE id = #{@id};")
    #add in more deletes when join tables and appointment tables are created
  end

  def self.patient_count
    docs_patients = []
    self.all.each do |doctor|
      doc_id = doctor.id
      patient_count = DB.exec("SELECT COUNT (*) FROM doctor_patient WHERE doctor_id = #{doc_id};")
      number = patient_count.first['count'].to_i
      docs_patients << [doctor, number]
    end
    docs_patients
  end

  def add_patient(patient_id)
    DB.exec("INSERT INTO doctor_patient (doctor_id, patient_id) VALUES (#{@id}, #{patient_id})")
  end

  def patients_list
    patients = []
    results = DB.exec("SELECT patient.* FROM doctor JOIN doctor_patient ON (doctor.id = doctor_patient.doctor_id)
                      JOIN patient ON (doctor_patient.patient_id = patient.id) WHERE doctor.id = #{@id};")
    results.each do |result|
      id = result['id'].to_i
      name = result['name']
      birthdate = result['birthdate']
      patients << Patient.new({'name' => name, 'birthdate' => birthdate, 'id' => id})
    end
    patients
  end

end
