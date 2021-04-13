public class Ordenador {
    private String codigo;
    private String procesador;
    private String memoria;

    public Ordenador(String codigo, String procesador, String memoria) {
        this.codigo = codigo;
        this.procesador = procesador;
        this.memoria = memoria;
    }

    @Override
    public String toString() {
        return "Ordenador{" +
                "codigo='" + codigo + '\'' +
                ", procesador='" + procesador + '\'' +
                ", memoria='" + memoria + '\'' +
                '}';
    }
}
