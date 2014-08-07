class Patient

  attr_reader :name, :birthdate, :doctor_id

  def initialize(attributes)
    @name = attributes['name']
    @birthdate = attributes['birthdate']
    @doctor_id = attributes['doctor_id']
  end

end
