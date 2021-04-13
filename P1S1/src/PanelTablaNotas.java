import javax.swing.*;
import javax.swing.table.TableModel;

/**
 * GUI para mostrar la tabla de notas
 */
public class PanelTablaNotas {
    private JTable tabla;
    private JPanel panel;
    private JScrollPane scrollPane;

    /**
     * Actualiza el modelo de datos de la tabla
     * @param model modelo de datos de la tabla
     */
    public void setModel(TableModel model) {
        tabla.setModel(model);
    }

    /**
     * Muestra la ventana y hace visible el panel
     */
    public void setVisible() {
        JFrame frame = new JFrame("Tabla Notas");
        frame.setContentPane(panel);
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }

    /**
     * Repinta el panel
     */
    public void repaint() {
        panel.repaint();
    }
}
