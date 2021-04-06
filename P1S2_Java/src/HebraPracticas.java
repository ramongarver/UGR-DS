import java.util.ArrayList;
import java.util.Random;

public class HebraPracticas extends Thread {

    static final String[] procesadores = {"i3", "i5", "i7", "AMD R5", "AMD R7"};
    static final String[] memorias = {"8GB", "16GB", "32GB"};
    Random rand = new Random();

    @Override
    public void run() {
        FactoriaDocencia factoriaDocencia = new FactoriaPracticas();
        Docencia docencia = new Docencia(factoriaDocencia);

        iniciarBucle(docencia);
    }

    private void iniciarBucle(Docencia docencia) {
        for(int i = 0; i < 25; i++) {
            try {
                sleep(750);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            construirGrupoAula(docencia, i);
            System.out.println(docencia + "\n\n");
        }
    }

    private void construirGrupoAula(Docencia docencia, int i) {
        docencia.addGrupo("Grupo_P" + (char)('A' + i));
        docencia.addAula("Aula_P" + i);
        docencia.asignarAulaGrupo("Aula_P" + i, "Grupo_P" + (char)('A' + i));
        addOrdenadores(docencia, i);
    }

    private void addOrdenadores(Docencia docencia, int i) {
        for (int j = 0; j < 15; j++) {
            Ordenador o = new Ordenador("Equipo_" + j, procesadores[rand.nextInt(procesadores.length)], memorias[rand.nextInt(memorias.length)]);
            docencia.addOrdenador("Aula_P" + i, o);
        }
    }
}
