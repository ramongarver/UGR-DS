import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;

public class GeneradorMedias extends Thread implements Observer {

    private double media;
    private ArrayList<Nota> calificaciones;
    private final Notas contenedorNotas;

    PanelMedia panelMedia;

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

    @Override
    public void run() {
        panelMedia = new PanelMedia();

        while(true) {
            try {
                sleep(3000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}