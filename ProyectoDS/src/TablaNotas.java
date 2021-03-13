import javax.swing.table.DefaultTableModel;
import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;

/**
 * Observador TablaNotas. Muestra las notas en una tabla.
 */
public class TablaNotas implements Observer {
    private final Notas sujeto;
    private ArrayList<Nota> calificaciones;
    private final PanelTablaNotas panelTablaNotas;
    private final DefaultTableModel modeloTabla;
    private final String[] columnNames = new String[]{"Nombre", "Nota"};

    /**
     * Construye el observador {@link TablaNotas}.
     * @param n Sujeto a observar
     */
    public TablaNotas(Notas n) {
        sujeto = n;
        calificaciones = new ArrayList<>();
        panelTablaNotas = new PanelTablaNotas();
        modeloTabla = new NonEditableTableModel(getMatrix(), columnNames);
        initializeTable();
    }

    /** Actualiza la tabla con los nuevos datos.
     *
     * @param observable Sujeto que ha cambiado
     * @param arg Información suministrada por el sujeto
     */
    @Override
    public void update(Observable observable, Object arg) {
        if (observable == sujeto) {
            //noinspection unchecked
            calificaciones = (ArrayList<Nota>) arg;
            modeloTabla.setDataVector(getMatrix(), columnNames);
            panelTablaNotas.repaint();
        }
    }

    /**
     * Calcula un objeto String[][] con el array de calificaciones.
     * @return array con String para mostrar en la tabla
     */
    private String[][] getMatrix() {
        String[][] res = new String[calificaciones.size()][2];

        for(int i = 0; i < calificaciones.size(); i++) {
            res[i][0] = calificaciones.get(i).getEstudiante();
            res[i][1] = String.format("%.2f", calificaciones.get(i).getCalificacion());
        }

        return res;
    }

    /**
     * Inicializa la tabla pasándole el modelo y haciéndola visible
     */
    private void initializeTable() {
        panelTablaNotas.setModel(modeloTabla);
        panelTablaNotas.setVisible();
    }

    /**
     * Representa el modelo de datos de una tabla con celdas que no se pueden editar
     */
    private static class NonEditableTableModel extends DefaultTableModel {
        public NonEditableTableModel(Object[][] rowData, Object[] columnNames) {
            super(rowData, columnNames);
        }

        @Override
        public boolean isCellEditable(int row, int column) {
            // all cells are non-editable
            return false;
        }
    }
}
