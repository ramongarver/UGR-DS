import java.util.NoSuchElementException;
import java.util.Observable;
import java.util.ArrayList;

/**
 * Representa un conjunto de notas
 */
public class Notas extends Observable {
    private final ArrayList<Nota> calificaciones;   // Contenedor de las calificaciones

    /**
     * Construye un objeto Notas con un contenedor de calificaciones vacío
     */
    public Notas() {
        super();
        calificaciones = new ArrayList<>();
    }

    /**
     * Añade una nota
     * @param estudiante Nombre del estudiante
     * @param nota Nota del estudiante
     */
    public void addNota(String estudiante, double nota) {
        calificaciones.add(new Nota(estudiante, nota));
        setChanged();
        notifyObservers(getState());
    }

    /**
     * Cambia la nota de un estudiante
     * @param estudiante Nombre del estudiante
     * @param nota Nueva nota
     * @throws NoSuchElementException si no se encuentra al estudiante
     */
    public void changeNota(String estudiante, double nota) throws NoSuchElementException {
        Nota estudianteBuscado = buscarEstudiante(estudiante);

        if(estudianteBuscado == null)
            throw new NoSuchElementException("No se ha encontrado al estudiante");

        estudianteBuscado.setCalificacion(nota);
        setChanged();
        notifyObservers(getState());
    }

    /**
     * Cambia el nombre de un estudiante
     * @param oldName Antiguo nombre
     * @param newName Nuevo nombre
     * @throws NoSuchElementException si no se encuentra al estudiante
     */
    public void changeEstudiante(String oldName, String newName) throws NoSuchElementException {
        Nota estudianteBuscado = buscarEstudiante(oldName);

        if(estudianteBuscado == null)
            throw new NoSuchElementException("No se ha encontrado al estudiante");

        estudianteBuscado.setEstudiante(newName);
        setChanged();
        notifyObservers(getState());
    }

    /**
     * Busca a un estudiante en el array
     * @param estudiante Nombre del estudiante
     * @return Referencia al objeto Nota de ese estudiante
     */
    private Nota buscarEstudiante(String estudiante) {
        return calificaciones.stream()
                .filter(elemento -> estudiante.equals(elemento.getEstudiante()))
                .findAny()
                .orElse(null);
    }

    /**
     * Devuelve una copia del contenedor de calificaciones
     * @return copia de calificaciones
     */
    public ArrayList<Nota> getState() {
        return new ArrayList<>(calificaciones);
    }

}