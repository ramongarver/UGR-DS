import java.util.Observable;
import java.util.Observer;
import java.util.ArrayList;

public class CalculadoraExtremos implements Observer {

    private double max;
    private double min;
    private ArrayList<Nota> calificaciones;
    private final Notas contenedorNotas;

    public CalculadoraExtremos(Notas n) {
        contenedorNotas = n;
        max = Float.MIN_VALUE;
        min = Float.MAX_VALUE;
        calificaciones = new ArrayList<>();
    }

    @Override
    public void update(Observable observable, Object arg) {
        if(observable == contenedorNotas) {
            calificaciones = contenedorNotas.getState();
            max = calcularMaximo();
            min = calcularMinimo();
        }
    }

    private double calcularMaximo() {
        double max = Float.MIN_VALUE;
        for(Nota calificacion : calificaciones)
            if(calificacion.getCalificacion() > max)
                max = calificacion.getCalificacion();

        return max;
    }

    private double calcularMinimo() {
        double min = Float.MAX_VALUE;
        for (Nota calificacion : calificaciones)
            if (calificacion.getCalificacion() < min)
                min = calificacion.getCalificacion();

        return min;
    }
}