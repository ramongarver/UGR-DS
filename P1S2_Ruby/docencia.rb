require_relative 'aula_practicas'

class Docencia
  def initialize(factoria_docencia)
    @factoria_docencia = factoria_docencia
    @aulas = []
    @grupos = []
  end

  def add_aula(nombre_aula)
    @aulas << @factoria_docencia.crear_aula(nombre_aula)
  end

  def add_grupo(nombre_grupo)
    @grupos << @factoria_docencia.crear_grupo(nombre_grupo)
  end

  def asignar_aula_grupo(nombre_aula, nombre_grupo)
    grupo_buscado = @grupos.find { |item| item.nombre == nombre_grupo }
    raise ArgumentError, 'Grupo solicitado no existe' if grupo_buscado.nil?

    aula_buscada = @aulas.find { |item| item.nombre == nombre_aula }
    raise ArgumentError, 'Aula solicitada no existe' if aula_buscada.nil?

    grupo_buscado.asignar_aula(aula_buscada)
  end

  def add_ordenador(nombre_aula, ordenador)
    aula_buscada = @aulas.find { |item| item.nombre == nombre_aula }
    raise ArgumentError, 'Aula solicitada no existe' if aula_buscada.nil?

    raise ArgumentError, 'Aula solicitada no es de prácticas' unless aula_buscada.is_a? AulaPracticas

    aula_buscada.add_ordenador(ordenador)
  end

  def to_s
    s = "Docencia{grupos=["
    @grupos.each { |grupo|
      s += grupo.to_s
    }
    s += "], aulas=#{@aulas}}"
  end
end
