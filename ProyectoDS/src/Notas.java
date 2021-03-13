import java.util.NoSuchElementException;
import java.util.Observable;
import java.util.ArrayList;

public class Notas extends Observable {
    private final ArrayList<Nota> calificaciones;

    public Notas() {
        super();
        calificaciones = new ArrayList<>();
    }

    public void addNota(String estudiante, double nota) {
        calificaciones.add(new Nota(estudiante, nota));
        setChanged();
        notifyObservers(getState());
    }

    public void changeNota(String estudiante, double nota) throws NoSuchElementException {
        Nota estudianteBuscado = buscarEstudiante(estudiante);

        if(estudianteBuscado == null)
            throw new NoSuchElementException("No se ha encontrado al estudiante");

        estudianteBuscado.setCalificacion(nota);
        setChanged();
        notifyObservers(getState());
    }

    public void changeEstudiante(String oldName, String newName) throws NoSuchElementException {
        Nota estudianteBuscado = buscarEstudiante(oldName);

        if(estudianteBuscado == null)
            throw new NoSuchElementException("No se ha encontrado al estudiante");

        estudianteBuscado.setEstudiante(newName);
        setChanged();
        notifyObservers(getState());
    }

    private Nota buscarEstudiante(String estudiante) {
        return calificaciones.stream()
                .filter(elemento -> estudiante.equals(elemento.getEstudiante()))
                .findAny()
                .orElse(null);
    }

    public ArrayList<Nota> getState() {
        return new ArrayList<>(calificaciones);
    }

}