import javax.swing.*;
import javax.swing.table.TableModel;

public class PanelTablaNotas {
    private JTable tabla;
    private JPanel panel;
    private JScrollPane scrollPane;

    public void setVisible() {
        JFrame frame = new JFrame("Tabla Notas");
        frame.setContentPane(panel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }

    public void repaint() {
        panel.repaint();
    }

    public void setModel(TableModel model) {
        tabla.setModel(model);
    }
}
