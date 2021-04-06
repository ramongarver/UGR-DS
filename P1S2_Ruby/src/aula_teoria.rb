require_relative 'aula'

class AulaTeoria < Aula
  def initialize(nombre)
    super
    puts "Creada aula #{@nombre} de teoría"
  end

  def to_s
    "AulaTeoria{nombre=#{@nombre}"
  end
end
