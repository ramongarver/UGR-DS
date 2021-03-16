public class GrupoTeoria extends Grupo {
    private AulaTeoria aula;

    public GrupoTeoria(String nombre) {
        super(nombre);
        System.out.println("teoría.");
    }

    @Override
    void asignarAula(Aula aula) {
        this.aula = (AulaTeoria) aula;
    }

    @Override
    public String toString() {
        return "GrupoTeoria{" +
                "nombre='" + nombre + '\'' +
                ", aula=" + aula +
                '}';
    }
}
