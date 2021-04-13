import java.util.Random;

/**
 * Se encarga de la simulación del añadido de notas
 */
public class ControlNotas extends Thread {
    private final Notas notas;

    /**
     * Inicializa el simulador de un sujeto que cambia
     * @param notas Sujeto que cambia
     */
    public ControlNotas(Notas notas) {
        this.notas = notas;
    }

    @Override
    public void run() {
        Random r = new Random();
        int contador = 1;

        //noinspection InfiniteLoopStatement
        while(true) {
            notas.addNota("Estudiante " + contador, generateRandomDouble(r, 0, 10));
            contador++;
            try {
                //noinspection BusyWait
                sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Genera un double aleatorio
     * @param r objeto Random
     * @param min límite inferior
     * @param max límite superior
     * @return double aleatorio
     */
    private double generateRandomDouble(Random r, double min, double max) {
        return max * r.nextDouble() + min;
    }
}
