class Patient

  attr_reader :name, :birthdate, :doctor_id, :id

  def initialize(attributes)
    @name = attributes['name']
    @birthdate = attributes['birthdate']
    @doctor_id = attributes['doctor_id']
    @id = attributes['id']
  end

  def self.all
    []
  end

end
