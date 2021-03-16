/**
 * Se encarga de la ejecución del programa principal
 */
public class Controlador {
    /**
     * Ejecuta el programa principal
     * @param args Argumentos de entrada (si los hay)
     */
    public static void main(String[] args) {
        Notas notas = new Notas();                                                  // Sujeto
        ControlNotas controlNotas = new ControlNotas(notas);                        // Simulación de notas
        GeneradorMedias generadorMedias = new GeneradorMedias(notas);               // Observador NO suscrito
        CalculadoraExtremos calculadoraExtremos = new CalculadoraExtremos(notas);   // Observador suscrito
        TablaNotas tablaNotas = new TablaNotas(notas);                              // Observador suscrito

        // Añadir observadores suscritos al sujeto
        notas.addObserver(calculadoraExtremos);
        notas.addObserver(tablaNotas);

        // Iniciar simulación de añadido de notas
        controlNotas.start();

        // Iniciar hebra de observador NO suscrito
        generadorMedias.start();
    }
}
