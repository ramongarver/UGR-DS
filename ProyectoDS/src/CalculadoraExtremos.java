import java.util.Observable;
import java.util.Observer;
import java.util.ArrayList;

public class CalculadoraExtremos extends Thread implements Observer {

    private double max;
    private double min;
    private ArrayList<Nota> calificaciones;
    private final Notas contenedorNotas;

    PanelExtremos panelExtremos;

    public CalculadoraExtremos(Notas n) {
        panelExtremos = new PanelExtremos();
        contenedorNotas = n;
        max = Float.MIN_VALUE;
        min = Float.MAX_VALUE;
        calificaciones = new ArrayList<>();
    }

    @Override
    public void update(Observable observable, Object arg) {
        if(observable == contenedorNotas) {
            calificaciones = (ArrayList<Nota>) arg;
            max = calcularMaximo();
            min = calcularMinimo();
            panelExtremos.setMaximo(max);
            panelExtremos.setMinimo(min);
        }
    }

    private double calcularMaximo() {
        double max = Double.MIN_VALUE;
        for(Nota calificacion : calificaciones)
            if(calificacion.getCalificacion() > max)
                max = calificacion.getCalificacion();

        return max;
    }

    private double calcularMinimo() {
        double min = Double.MAX_VALUE;
        for (Nota calificacion : calificaciones)
            if (calificacion.getCalificacion() < min)
                min = calificacion.getCalificacion();

        return min;
    }

    @Override
    public void run() {
        panelExtremos.setVisible();

        while(true) {
            try {
                sleep(3000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}