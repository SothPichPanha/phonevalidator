import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.io.*;

public class PhoneValidatorGUI extends JFrame {

    private JTextField inputField;
    private JButton validateButton;
    private JButton clearButton;
    private JTextArea outputArea;
    private JLabel statusLabel;

    public PhoneValidatorGUI() {
        setTitle("Phone Number Validator");
        setSize(600, 500);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout(10, 10));
        setLocationRelativeTo(null); // Center on screen

        // Create main panel with padding
        JPanel mainPanel = new JPanel(new BorderLayout(10, 10));
        mainPanel.setBorder(BorderFactory.createEmptyBorder(15, 15, 15, 15));

        // Input panel
        JPanel inputPanel = createInputPanel();
        
        // Output panel
        JPanel outputPanel = createOutputPanel();
        
        // Status panel
        JPanel statusPanel = createStatusPanel();

        mainPanel.add(inputPanel, BorderLayout.NORTH);
        mainPanel.add(outputPanel, BorderLayout.CENTER);
        mainPanel.add(statusPanel, BorderLayout.SOUTH);

        add(mainPanel);

        // Add keyboard shortcuts
        setupKeyboardShortcuts();
    }

    private JPanel createInputPanel() {
        JPanel panel = new JPanel(new BorderLayout(10, 10));
        panel.setBorder(BorderFactory.createTitledBorder("Input"));

        JLabel label = new JLabel("Enter Phone Number:");
        label.setFont(new Font("Arial", Font.BOLD, 12));

        inputField = new JTextField();
        inputField.setFont(new Font("Monospaced", Font.PLAIN, 14));
        inputField.addActionListener(e -> validateNumber()); // Validate on Enter

        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT, 5, 0));
        validateButton = new JButton("Validate");
        validateButton.setPreferredSize(new Dimension(100, 30));
        validateButton.addActionListener(e -> validateNumber());

        clearButton = new JButton("Clear");
        clearButton.setPreferredSize(new Dimension(100, 30));
        clearButton.addActionListener(e -> clearAll());

        buttonPanel.add(validateButton);
        buttonPanel.add(clearButton);

        panel.add(label, BorderLayout.NORTH);
        panel.add(inputField, BorderLayout.CENTER);
        panel.add(buttonPanel, BorderLayout.EAST);

        return panel;
    }

    private JPanel createOutputPanel() {
        JPanel panel = new JPanel(new BorderLayout());
        panel.setBorder(BorderFactory.createTitledBorder("Validation Results"));

        outputArea = new JTextArea();
        outputArea.setEditable(false);
        outputArea.setFont(new Font("Monospaced", Font.PLAIN, 12));
        outputArea.setLineWrap(true);
        outputArea.setWrapStyleWord(true);
        outputArea.setMargin(new Insets(5, 5, 5, 5));

        JScrollPane scrollPane = new JScrollPane(outputArea);
        scrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);

        panel.add(scrollPane, BorderLayout.CENTER);

        return panel;
    }

    private JPanel createStatusPanel() {
        JPanel panel = new JPanel(new BorderLayout());
        statusLabel = new JLabel(" ");
        statusLabel.setFont(new Font("Arial", Font.ITALIC, 11));
        statusLabel.setForeground(Color.blue);
        panel.add(statusLabel, BorderLayout.WEST);
        return panel;
    }

    private void setupKeyboardShortcuts() {
        // Ctrl+Enter to check
        KeyStroke validateKey = KeyStroke.getKeyStroke(KeyEvent.VK_ENTER, InputEvent.CTRL_DOWN_MASK);
        getRootPane().getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW).put(validateKey, "check");
        getRootPane().getActionMap().put("check", new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                validateNumber();
            }
        });

        // Ctrl+L to clear
        KeyStroke clearKey = KeyStroke.getKeyStroke(KeyEvent.VK_L, InputEvent.CTRL_DOWN_MASK);
        getRootPane().getInputMap(JComponent.WHEN_IN_FOCUSED_WINDOW).put(clearKey, "clear");
        getRootPane().getActionMap().put("clear", new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                clearAll();
            }
        });
    }

    private void validateNumber() {
        String text = inputField.getText().trim();
        
        if (text.isEmpty()) {
            showError("Please enter a phone number!");
            return;
        }

        // Disable button during processing
        validateButton.setEnabled(false);
        statusLabel.setText("Validating...");
        statusLabel.setForeground(Color.BLUE);

        // Run validation in background thread
        SwingWorker<String, Void> worker = new SwingWorker<>() {
            @Override
            protected String doInBackground() {
                try {
                    PhoneValidator scanner = new PhoneValidator(new StringReader(text));

                    ByteArrayOutputStream buffer = new ByteArrayOutputStream();
                    PrintStream oldOut = System.out;
                    System.setOut(new PrintStream(buffer));

                    scanner.yylex();

                    System.setOut(oldOut);
                    return buffer.toString();

                } catch (IOException ex) {
                    return "Error: Unable to process input - " + ex.getMessage();
                } catch (Exception ex) {
                    return "Error: " + ex.getMessage();
                }
            }

            @Override
            protected void done() {
                try {
                    String result = get();
                    appendOutput(result);
                    statusLabel.setText("Validation complete");
                    statusLabel.setForeground(new Color(0, 128, 0));
                } catch (Exception ex) {
                    showError("Unexpected error: " + ex.getMessage());
                }
                validateButton.setEnabled(true);
            }
        };

        worker.execute();
    }

    private void appendOutput(String text) {
        if (!text.isEmpty()) {
            outputArea.append(String.format("%s\n%s\n", 
                inputField.getText(), text));
            outputArea.append("-".repeat(50) + "\n");
            outputArea.setCaretPosition(outputArea.getDocument().getLength());
        }
    }

    private void clearAll() {
        inputField.setText("");
        outputArea.setText("");
        statusLabel.setText(" ");
        inputField.requestFocus();
    }

    private void showError(String message) {
        JOptionPane.showMessageDialog(this, message, "Input Error", 
            JOptionPane.WARNING_MESSAGE);
        statusLabel.setText("Error");
        statusLabel.setForeground(Color.RED);
    }

    public static void main(String[] args) {
        // Set look and feel to system default
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception e) {
            // Use default if system look and feel fails
        }

        SwingUtilities.invokeLater(() -> {
            PhoneValidatorGUI frame = new PhoneValidatorGUI();
            frame.setVisible(true);
        });
    }
}