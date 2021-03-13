import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;

public class GeneradorMedias extends Thread implements Observer {

    private double media;
    private ArrayList<Nota> calificaciones;
    private final Notas contenedorNotas;

    private final PanelMedia panelMedia;

    public GeneradorMedias(Notas n) {
        panelMedia = new PanelMedia();
        contenedorNotas = n;
        this.media = -1.0;
        calificaciones = new ArrayList<>();
    }

    @Override
    public void update(Observable observable, Object arg) {
        if(observable == contenedorNotas) {
            calificaciones = (ArrayList<Nota>) arg;
            media = calcularMedia();
            panelMedia.setMedia(media);
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
        panelMedia.setVisible();

        while(true) {
            try {
                sleep(3000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            // Actualizar
            this.update(contenedorNotas, contenedorNotas.getState());
        }
    }
}