require_relative 'aula'

class AulaPracticas < Aula
  def initialize(nombre)
    super
    @ordenadores = []
    puts "Creada aula #{@nombre} de prácticas"
  end

  def add_ordenador(ordenador)
    @ordenadores << ordenador
  end

  def initialize_copy(orig)
    super
    @ordenadores = []
    puts 'AulaPracticas clonada'
  end
end
