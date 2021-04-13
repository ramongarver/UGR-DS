import javax.swing.*;

/**
 * GUI para mostrar máximo y mínimo
 */
public class PanelExtremos {
    private JTextField maximo;
    private JTextField minimo;
    private JPanel extremosPanel;

    /**
     * Actualiza el máximo
     * @param max máximo
     */
    public void setMaximo(double max) {
        maximo.setText(String.format("%.2f", max));
        extremosPanel.repaint();
    }

    /**
     * Actualiza el mínimo
     * @param min mínimo
     */
    public void setMinimo(double min) {
        minimo.setText(String.format("%.2f", min));
        extremosPanel.repaint();
    }

    /**
     * Muestra la ventana y hace visible el panel
     */
    public void setVisible() {
        JFrame frame = new JFrame("PanelExtremos");
        frame.setContentPane(extremosPanel);
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }
}
