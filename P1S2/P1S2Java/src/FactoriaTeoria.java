public class FactoriaTeoria extends FactoriaDocencia {

    public Aula crearAula(String nombre) {
        return new AulaTeoria(nombre);
    }

    public Grupo crearGrupo(String nombre) {
        return new GrupoTeoria(nombre);
    }
}
