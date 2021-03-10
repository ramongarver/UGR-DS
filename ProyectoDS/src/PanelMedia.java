import javax.swing.*;

public class PanelMedia {
    private JTextField media;
    private JPanel mediaPanel;

    public void setMedia(double m) {
        media.setText(Double.toString(m));
        mediaPanel.repaint();
    }

    public void setVisible() {
        JFrame frame = new JFrame("PanelMedia");
        frame.setContentPane(mediaPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }
}
