import java.util.Observable;
import java.util.Observer;
import java.util.ArrayList;

public class CalculadoraExtremos implements Observer {

	private float max;
	private float min;
	private ArrayList<Nota> calificaciones;
	private Observable objetoNotas;

	public CalculadoraExtremos(Observable o) {
		objetoNotas = o;
		max = Float.MIN_VALUE;
		min = Float.MAX_VALUE;
	}

	@Override
	public void update(Observable o, Object arg) {
		calificaciones = o.// OBTENER ARRAY DE CALIFICACIONES DE O
		max = calcularMaximo();
		min = calcularMinimo();
	}

	private float calcularMaximo() {
		max = Float.MIN_VALUE;
		for(Nota calificacion : calificaciones) {
			if(calificacion.getCalificacion() > max) {
				max = calificacion.getCalificacion();
			}
		}
	}

	private float calcularMinimo() {
		min = Float.MAX_VALUE;
		for (Nota calificacion : calificaciones)
			if (calificacion.getCalificacion() < min) {
				min = calificacion.getCalificacion();
			}
	}
}