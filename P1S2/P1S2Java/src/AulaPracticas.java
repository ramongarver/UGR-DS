import java.util.ArrayList;

public class AulaPracticas extends Aula {

    private final ArrayList<Ordenador> ordenadores;

    public AulaPracticas(String nombre) {
        super(nombre);
        ordenadores = new ArrayList<>();
        System.out.println("prácticas.");
    }

    public void addOrdenador(Ordenador ordenador) {
        ordenadores.add(ordenador);
    }

    @Override
    public String toString() {
        return "AulaPracticas{" +
                "nombre='" + nombre + '\'' +
                ", ordenadores=" + ordenadores +
                '}';
    }
}
