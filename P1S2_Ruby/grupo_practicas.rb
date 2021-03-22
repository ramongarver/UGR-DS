require_relative 'grupo'

class GrupoPracticas < Grupo
  def initialize(nombre)
    super
    puts "Creado grupo de prácticas #{@nombre}"
  end

  def to_s
    "GrupoPracticas{nombre='#{@nombre}', aula=#{@aula&.nombre}}"
  end
end
