import javax.swing.*;

public class PanelMedia {
    private JTextField media;
    private JPanel mediaPanel;

    public void setMedia(double m) {
        media.setText(Double.toString(m));
    }

    public void setVisible() {
        JFrame frame = new JFrame("PanelMedia");
        frame.setContentPane(new PanelMedia().mediaPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }
}
