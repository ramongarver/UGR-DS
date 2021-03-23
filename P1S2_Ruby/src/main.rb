require_relative 'aula_practicas'
require_relative 'grupo_practicas'
require_relative 'factoria_docencia'
require_relative 'docencia'
require_relative 'ordenador'

prototipo_aula = AulaPracticas.new('Aula de prácticas')
prototipo_grupo = GrupoPracticas.new('Grupo de prácticas')
factoria = FactoriaDocencia.new(prototipo_aula, prototipo_grupo)
docencia = Docencia.new(factoria)
docencia.add_aula('Aula 1')
docencia.add_grupo('Grupo A')
ordenador = Ordenador.new('o1', 'i7', '8GB')
docencia.add_ordenador('Aula 1', ordenador)
docencia.asignar_aula_grupo('Aula 1', 'Grupo A')
puts docencia
