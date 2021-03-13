import java.util.Observable;
import java.util.Observer;
import java.util.ArrayList;

/**
 * Observador CalculadoraExtremos. Calcula máximo y mínimo entre todas las notas y las muestra.
 */
public class CalculadoraExtremos implements Observer {

    private double max;
    private double min;
    private ArrayList<Nota> calificaciones;
    private final Notas sujeto;

    private final PanelExtremos panelExtremos;

    /**
     * Construye el observador {@link CalculadoraExtremos}.
     * @param n Sujeto a observar
     */
    public CalculadoraExtremos(Notas n) {
        panelExtremos = new PanelExtremos();
        sujeto = n;
        max = Float.MIN_VALUE;
        min = Float.MAX_VALUE;
        calificaciones = new ArrayList<>();
        panelExtremos.setVisible();
    }

    /** Recalcula máximo y mínimo y se actualizan en el panel.
     *
     * @param observable Sujeto que ha cambiado
     * @param arg Información suministrada por el sujeto
     */
    @Override
    public void update(Observable observable, Object arg) {
        if(observable == sujeto) {
            //noinspection unchecked
            calificaciones = (ArrayList<Nota>) arg;
            max = calcularMaximo();
            min = calcularMinimo();
            panelExtremos.setMaximo(max);
            panelExtremos.setMinimo(min);
        }
    }

    /**
     * Calcula el máximo entre las notas
     * @return máximo
     */
    private double calcularMaximo() {
        double max = Double.MIN_VALUE;
        for(Nota calificacion : calificaciones)
            if(calificacion.getCalificacion() > max)
                max = calificacion.getCalificacion();

        return max;
    }

    /**
     * Calcula el mínimo entre las notas
     * @return mínimo
     */
    private double calcularMinimo() {
        double min = Double.MAX_VALUE;
        for (Nota calificacion : calificaciones)
            if (calificacion.getCalificacion() < min)
                min = calificacion.getCalificacion();

        return min;
    }
}