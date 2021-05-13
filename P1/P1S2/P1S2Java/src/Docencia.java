import java.util.ArrayList;
import java.util.NoSuchElementException;

public class Docencia {
    FactoriaDocencia factoriaDocencia;
    ArrayList<Aula> aulas = new ArrayList<>();
    ArrayList<Grupo> grupos = new ArrayList<>();

    public Docencia(FactoriaDocencia factoriaDocencia) {
        this.factoriaDocencia = factoriaDocencia;
    }

    public void addAula(String nombreAula) {
        aulas.add(factoriaDocencia.crearAula(nombreAula));
    }

    public void addGrupo(String nombreGrupo) {
        grupos.add(factoriaDocencia.crearGrupo(nombreGrupo));
    }

    public void asignarAulaGrupo(String nombreAula, String nombreGrupo) throws NoSuchElementException {
        Grupo grupoBuscado = buscarGrupo(nombreGrupo);
        if(grupoBuscado == null)
            throw new NoSuchElementException("No se ha encontrado el grupo");

        Aula aulaBuscada = buscarAula(nombreAula);
        if(aulaBuscada == null)
            throw new NoSuchElementException("No se ha encontrado el aula");

        grupoBuscado.asignarAula(aulaBuscada);
    }

    private Aula buscarAula(String nombreAula) {
        return aulas.stream()
                .filter(elemento -> nombreAula.equals(elemento.getNombre()))
                .findAny()
                .orElse(null);
    }

    private Grupo buscarGrupo(String nombreGrupo) {
        return grupos.stream()
                .filter(elemento -> nombreGrupo.equals(elemento.getNombre()))
                .findAny()
                .orElse(null);
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("Docencia{");
        //sb.append("aulas=").append(aulas);
        sb.append("grupos=").append(grupos);
        sb.append('}');
        return sb.toString();
    }

    public void addOrdenador(String nombreAula, Ordenador ordenador) throws NoSuchElementException {
        AulaPracticas aulaBuscada = (AulaPracticas)buscarAula(nombreAula);
        if(aulaBuscada == null)
            throw new NoSuchElementException("No se ha encontrado el aula");

        aulaBuscada.addOrdenador(ordenador);
    }
}
