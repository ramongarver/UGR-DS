import java.util.Observable;
import java.util.ArrayList;

public class Notas extends Observable {
	ArrayList<Nota> calificaciones;


	public Notas() {

	}

	public void addNota(String estudiante, float nota) {
		calificaciones.add(new Nota(estudiante, nota));
	}

	public ArrayList<Nota> getState() {
		return calificaciones;
	}

	/**
	 * 
	 * @param calificaciones
	 */
	public void setState(ArrayList<Nota> calificaciones) {
		this.calificaciones = calificaciones;
	}

}