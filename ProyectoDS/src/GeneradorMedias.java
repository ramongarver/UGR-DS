import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;

/**
 * Observador GeneradorMedias. Calcula la media todas las notas y la muestra.
 */
public class GeneradorMedias extends Thread implements Observer {

    private double media;
    private ArrayList<Nota> calificaciones;
    private final Notas sujeto;

    private final PanelMedia panelMedia;

    /**
     * Construye el observador {@link GeneradorMedias}.
     * @param n Sujeto a observar
     */
    public GeneradorMedias(Notas n) {
        panelMedia = new PanelMedia();
        sujeto = n;
        this.media = -1.0;
        calificaciones = new ArrayList<>();
    }

    /** Recalcula la media y se actualiza en el panel.
     *
     * @param observable Sujeto que ha cambiado
     * @param arg Información suministrada por el sujeto
     */
    @Override
    public void update(Observable observable, Object arg) {
        if(observable == sujeto) {
            //noinspection unchecked
            calificaciones = (ArrayList<Nota>) arg;
            media = calcularMedia();
            panelMedia.setMedia(media);
        }
    }

    /**
     * Calcula la media de todas las notas
     * @return media
     */
    private double calcularMedia() {
        double suma = 0.0;
        for (Nota n : calificaciones)
            suma += n.getCalificacion();

        return suma / calificaciones.size();
    }

    /**
     * Ejecución como hebra del observador NO suscrito
     */
    @Override
    public void run() {
        panelMedia.setVisible();

        //noinspection InfiniteLoopStatement
        while(true) {
            try {
                //noinspection BusyWait
                sleep(3000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            // Actualizar
            this.update(sujeto, sujeto.getState());
        }
    }
}