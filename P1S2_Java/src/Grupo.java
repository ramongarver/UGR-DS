public abstract class Grupo {
    protected String nombre;

    protected Grupo(String nombre) {
        this.nombre = nombre;
        System.out.print("Creado grupo \"" + nombre + "\" de ");
    }

    public String getNombre() { return nombre; }


    abstract void asignarAula(Aula aula);
}
