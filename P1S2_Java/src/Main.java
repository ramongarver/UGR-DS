public class Main {

    public static void main(String[] args) {

        FactoriaDocencia factoriaDocencia = new FactoriaPracticas();
        Docencia docencia = new Docencia(factoriaDocencia);

        Ordenador o = new Ordenador("un ordenador", "i7", "8GB");
        docencia.addAula("Aula 1");
        docencia.addGrupo("Grupo A");
        docencia.asignarAulaGrupo("Aula 1", "Grupo A");
        docencia.addOrdenador("Aula 1", o);

        System.out.println(docencia);
    }
}
