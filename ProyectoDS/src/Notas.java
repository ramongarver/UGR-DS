import java.util.NoSuchElementException;
import java.util.Observable;
import java.util.ArrayList;

public class Notas extends Observable {
    ArrayList<Nota> calificaciones;

    public Notas() {
        super();
        calificaciones = new ArrayList<>();
    }

    public void addNota(String estudiante, float nota) {
        calificaciones.add(new Nota(estudiante, nota));
        setChanged();
        notifyObservers(getState());
    }

    public void changeNota(String estudiante, float nota) throws NoSuchElementException {
        Nota buscada = calificaciones.stream()
                .filter(elemento -> estudiante.equals(elemento.getEstudiante()))
                .findAny()
                .orElse(null);

        if(buscada == null) {
            throw new NoSuchElementException("No se ha encontrado al estudiante");
        }

        buscada.setCalificacion(nota);
        setChanged();
        notifyObservers(getState());
    }

    public void changeEstudiante(String oldName, String newName) throws NoSuchElementException {
        Nota buscada = calificaciones.stream()
                .filter(elemento -> oldName.equals(elemento.getEstudiante()))
                .findAny()
                .orElse(null);

        if(buscada == null) {
            throw new NoSuchElementException("No se ha encontrado al estudiante");
        }

        buscada.setEstudiante(newName);
        setChanged();
        notifyObservers(getState());
    }

    public ArrayList<Nota> getState() {
        return new ArrayList<>(calificaciones);
    }

}