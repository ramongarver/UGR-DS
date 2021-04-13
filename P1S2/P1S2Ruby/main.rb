require_relative 'aula_practicas'
require_relative 'grupo_practicas'
require_relative 'aula_teoria'
require_relative 'grupo_teoria'
require_relative 'factoria_docencia'
require_relative 'docencia'
require_relative 'ordenador'

PROCESADORES = ['i3', 'i5', 'i7', 'AMD R5', 'AMD R7'].freeze
MEMORIAS = %w[8GB 16GB 32GB].freeze

def add_aulas_practicas(docencia, numero_aulas, numero_ordenadores)
  (0...numero_aulas).each do |i|
    docencia.add_aula("Aula_P#{i}")

    (0...numero_ordenadores.to_i).each do |j|
      ordenador = Ordenador.new("Equipo_#{j}", PROCESADORES[rand(PROCESADORES.length)], MEMORIAS[rand(MEMORIAS.length)])
      docencia.add_ordenador("Aula_P#{i}", ordenador)
    end
  end
end

def add_grupos(docencia, letra_tipo, numero_aulas, numero_grupos)
  letra = 'A'
  (0...numero_grupos).each do |i|
    docencia.add_grupo("Grupo_#{letra_tipo}#{letra}")
    docencia.asignar_aula_grupo("Aula_#{letra_tipo}#{i % numero_aulas}", "Grupo_#{letra_tipo}#{letra}")
    letra.next!
  end
end

def add_grupos_practicas(docencia, numero_aulas, numero_grupos)
  add_grupos(docencia, 'P', numero_aulas, numero_grupos)
end

def crear_edificio_practicas(numero_grupos, numero_aulas, numero_ordenadores)
  prototipo_aula = AulaPracticas.new('Aula Practicas')
  prototipo_grupo = GrupoPracticas.new('Grupo Practicas')
  factoria = FactoriaDocencia.new(prototipo_aula, prototipo_grupo)
  docencia = Docencia.new(factoria)

  add_aulas_practicas(docencia, numero_aulas, numero_ordenadores)

  add_grupos_practicas(docencia, numero_aulas, numero_grupos)

  puts docencia
end

def add_aulas_teoria(docencia, numero_aulas)
  (0...numero_aulas).each do |i|
    docencia.add_aula("Aula_T#{i}")
  end
end

def add_grupos_teoria(docencia, numero_aulas, numero_grupos)
  add_grupos(docencia, 'T', numero_aulas, numero_grupos)
end

def crear_edificio_teoria(numero_grupos, numero_aulas)
  prototipo_aula = AulaTeoria.new('Aula Teoría')
  prototipo_grupo = GrupoTeoria.new('Grupo Teoría')
  factoria = FactoriaDocencia.new(prototipo_aula, prototipo_grupo)
  docencia = Docencia.new(factoria)

  add_aulas_teoria(docencia, numero_aulas)
  add_grupos_teoria(docencia, numero_aulas, numero_grupos)

  puts docencia
end

puts '|| Bienvenido a la fábrica de la universidad ||'

puts
puts '-- Es la hora de crear el edificio de prácticas --'
puts 'Introduzca el número de grupos que desea crear: '
numero_grupos = gets.to_i
puts 'Introduzca el número de aulas que desea crear: '
numero_aulas = gets.to_i
puts 'Introduzca el número de ordenadores que desea para cada aula: '
numero_ordenadores = gets.to_i
puts
crear_edificio_practicas(numero_grupos, numero_aulas, numero_ordenadores)

puts
puts '-- Es la hora de crear el edificio de teoría --'
puts 'Introduzca el número de grupos que desea crear: '
numero_grupos = gets.to_i
puts 'Introduzca el número de aulas que desea crear: '
numero_aulas = gets.to_i
puts
crear_edificio_teoria(numero_grupos, numero_aulas)
