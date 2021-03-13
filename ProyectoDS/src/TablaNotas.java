import javax.swing.table.DefaultTableModel;
import java.util.ArrayList;
import java.util.Observable;
import java.util.Observer;

public class TablaNotas implements Observer {
    private final Notas sujeto;
    private ArrayList<Nota> calificaciones;
    private final PanelTablaNotas panelTablaNotas;
    private final DefaultTableModel modeloTabla;
    private final String[] columnNames = new String[]{"Nombre", "Nota"};

    public TablaNotas(Notas n) {
        sujeto = n;
        calificaciones = new ArrayList<>();
        panelTablaNotas = new PanelTablaNotas();
        modeloTabla = new NonEditableTableModel(getMatrix(), columnNames);
        initializeTable();
    }

    @Override
    public void update(Observable observable, Object arg) {
        if (observable == sujeto) {
            calificaciones = (ArrayList<Nota>) arg;
            modeloTabla.setDataVector(getMatrix(), columnNames);
            panelTablaNotas.repaint();
        }
    }

    private String[][] getMatrix() {
        String[][] res = new String[calificaciones.size()][2];

        for(int i = 0; i < calificaciones.size(); i++) {
            res[i][0] = calificaciones.get(i).getEstudiante();
            res[i][1] = String.format("%.2f", calificaciones.get(i).getCalificacion());
        }

        return res;
    }

    private void initializeTable() {
        panelTablaNotas.setModel(modeloTabla);
        panelTablaNotas.setVisible();
    }

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
