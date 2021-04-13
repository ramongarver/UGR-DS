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
  end

  def to_s
    s = "AulaPracticas{nombre=#{@nombre}, ordenadores=["
    @ordenadores.each { |o| s += "#{o}, " }

    s += ']'
  end
end
