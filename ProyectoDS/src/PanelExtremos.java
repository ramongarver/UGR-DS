import javax.swing.*;

public class PanelExtremos {
    private JTextField maximo;
    private JTextField minimo;

    public void setMaximo(double max) {
        maximo.setText(Double.toString(max));
    }

    public void setMinimo(double min) {
        minimo.setText(Double.toString(min));
    }
}
