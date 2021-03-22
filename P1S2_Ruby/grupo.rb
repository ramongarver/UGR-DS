class Grupo
  def initialize(nombre)
    @nombre = nombre
  end

  def asignar_aula(aula)
    @aula = aula
  end

  attr_accessor :nombre
end
