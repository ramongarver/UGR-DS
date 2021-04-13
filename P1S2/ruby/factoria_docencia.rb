require_relative 'aula'
require_relative 'grupo'

class FactoriaDocencia
  def initialize(prototipo_aula, prototipo_grupo)
    raise ArgumentError, 'prototipo_aula no es Aula' unless prototipo_aula.is_a? Aula
    raise ArgumentError, 'prototipo_grupo no es Grupo' unless prototipo_grupo.is_a? Grupo

    @prototipo_aula = prototipo_aula
    @prototipo_grupo = prototipo_grupo
  end

  def crear_grupo(nombre)
    grupo = @prototipo_grupo.clone
    grupo.nombre = nombre
    grupo
  end

  def crear_aula(nombre)
    aula = @prototipo_aula.clone
    aula.nombre = nombre
    aula
  end
end
