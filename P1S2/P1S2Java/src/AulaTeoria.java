public class AulaTeoria extends Aula {

    public AulaTeoria(String nombre) {
        super(nombre);
        System.out.println("teoría.");
    }

    @Override
    public String toString() {
        return "AulaTeoria{" +
                "nombre='" + nombre + '\'' +
                '}';
    }
}
