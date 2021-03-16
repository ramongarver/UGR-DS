public class GrupoPracticas extends Grupo {
    private AulaPracticas aula;

    public GrupoPracticas(String nombre) {
        super(nombre);
        System.out.println("prácticas.");
    }

    @Override
    void asignarAula(Aula aula) {
        this.aula = (AulaPracticas) aula;
    }

    @Override
    public String toString() {
        return "GrupoPracticas{" +
                "nombre='" + nombre + '\'' +
                ", aula=" + aula +
                '}';
    }
}
