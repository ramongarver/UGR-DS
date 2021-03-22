class Ordenador
  def initialize(codigo, procesador, memoria)
    @codigo = codigo
    @procesador = procesador
    @memoria = memoria
  end

  def to_s
    "Ordenador{codigo='#{@codigo}', procesador='#{@procesador}', memoria='#{@memoria}'}"
  end
end
