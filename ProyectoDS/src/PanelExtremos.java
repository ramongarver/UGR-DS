import javax.swing.*;

public class PanelExtremos {
    private JTextField maximo;
    private JTextField minimo;
    private JPanel extremosPanel;

    public void setMaximo(double max) {
        maximo.setText(Double.toString(max));
    }

    public void setMinimo(double min) {
        minimo.setText(Double.toString(min));
    }

    public void setVisible() {
        JFrame frame = new JFrame("PanelExtremos");
        frame.setContentPane(new PanelExtremos().extremosPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }
}
