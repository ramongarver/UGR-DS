import javax.swing.*;

/**
 * GUI para mostrar la media
 */
public class PanelMedia {
    private JTextField media;
    private JPanel mediaPanel;

    /**
     * Actualiza la media
     * @param m media
     */
    public void setMedia(double m) {
        media.setText(String.format("%.2f", m));
        mediaPanel.repaint();
    }

    /**
     * Muestra la ventana y hace visible el panel
     */
    public void setVisible() {
        JFrame frame = new JFrame("PanelMedia");
        frame.setContentPane(mediaPanel);
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }
}
