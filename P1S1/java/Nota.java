/**
 * Representa una nota de un estudiante
 */
public class Nota {

    private String estudiante;
    private double calificacion;

    /**
     * Construye un objeto Nota
     * @param estudiante Nombre del estudiante
     * @param calificacion Calificación que ha obtenido
     */
    public Nota(String estudiante, double calificacion) {
        this.estudiante = estudiante;
        this.calificacion = calificacion;
    }

    public String getEstudiante() {
        return estudiante;
    }

    public double getCalificacion() {
        return calificacion;
    }

    public void setEstudiante(String estudiante) {
        this.estudiante = estudiante;
    }

    public void setCalificacion(double calificacion) {
        this.calificacion = calificacion;
    }
}