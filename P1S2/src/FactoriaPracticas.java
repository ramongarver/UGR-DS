public class FactoriaPracticas extends FactoriaDocencia {

    public AulaPracticas crearAula(String nombre) {
        return new AulaPracticas(nombre);
    }

    public GrupoPracticas crearGrupo(String nombre) {
        return new GrupoPracticas(nombre);
    }
}
