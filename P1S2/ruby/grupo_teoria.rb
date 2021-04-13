require_relative 'grupo'

class GrupoTeoria < Grupo
  def initialize(nombre)
    super
    puts "Creado grupo de teoría #{@nombre}"
  end

  def to_s
    "GrupoTeoria{nombre='#{@nombre}', aula=#{@aula&.nombre}}"
  end
end
