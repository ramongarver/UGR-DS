public abstract class Aula {
    protected String nombre;

    protected Aula(String nombre) {
        this.nombre = nombre;
        System.out.print("Creada aula \"" + nombre + "\" de ");
    }

    public String getNombre() { return nombre; }
}
