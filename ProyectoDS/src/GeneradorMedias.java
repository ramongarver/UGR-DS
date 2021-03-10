import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;

public class GeneradorMedias implements Observer {

    private double media;
    private ArrayList<Nota> calificaciones;
    private final Notas contenedorNotas;

    public GeneradorMedias(Notas n) {
        contenedorNotas = n;
        this.media = -1.0;
        calificaciones = new ArrayList<>();
    }

    @Override
    public void update(Observable observable, Object arg) {
        if(observable == contenedorNotas) {
            calificaciones = (ArrayList<Nota>) arg;
            media = calcularMedia();
        }
    }

    private double calcularMedia() {
        double suma = 0.0;
        for (Nota n : calificaciones)
            suma += n.getCalificacion();

        return suma / calificaciones.size();
    }
}