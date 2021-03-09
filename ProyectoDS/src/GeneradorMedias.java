import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;

public class GeneradorMedias implements Observer {

	private float media;
	private ArrayList<Nota> calificaciones;
	private Observable objetoNotas;

	public GeneradorMedias(Observable o) {
		objetoNotas = o;
		this.media = -1;
	}

	@Override
	public void update(Observable o, Object arg) {

	}
}