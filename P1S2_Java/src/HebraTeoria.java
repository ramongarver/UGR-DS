public class HebraTeoria extends Thread {
    @Override
    public void run() {
        FactoriaDocencia factoriaDocencia = new FactoriaTeoria();
        Docencia docencia = new Docencia(factoriaDocencia);

        iniciarBucle(docencia);
    }

    private void iniciarBucle(Docencia docencia) {
        for(int i = 0; i < 25; i++) {
            try {
                sleep(500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            construirGrupoAula(docencia, i);
            System.out.println(docencia + "\n\n");
        }
    }

    private void construirGrupoAula(Docencia docencia, int i) {
        docencia.addGrupo("Grupo_T" + (char)('A' + i));
        docencia.addAula("Aula_T" + i);
        docencia.asignarAulaGrupo("Aula_T" + i, "Grupo_T" + (char)('A' + i));
    }
}
