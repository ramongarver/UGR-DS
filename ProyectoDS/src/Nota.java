public class Nota {

	private String estudiante;
	private float calificacion;

	/**
	 * 
	 * @param estudiante
	 * @param calificacion
	 */
	public Nota(String estudiante, float calificacion) {
		this.estudiante = estudiante;
		this.calificacion = calificacion;
	}

	public String getEstudiante() {
		return estudiante;
	}

	public float getCalificacion() {
		return calificacion;
	}
}