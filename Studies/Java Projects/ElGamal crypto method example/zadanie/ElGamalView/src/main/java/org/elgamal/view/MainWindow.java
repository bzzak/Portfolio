package org.elgamal.view;

import com.google.common.base.Charsets;
import com.google.common.io.Files;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.RadioButton;
import javafx.stage.Stage;

import java.io.*;

import javafx.scene.control.TextField;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.stage.FileChooser;
import org.elgamal.model.OurFirstBigInt;
import org.elgamal.model.ElGamal;

import java.util.logging.Level;
import java.util.logging.Logger;

public class MainWindow{
    private final Stage stage;
    private final FileChooser chooser = new FileChooser();
    private File currentPlainText;
    private File currentCypherText;
    private final ElGamal cypher;

    @FXML
    private RadioButton plainRadio;

    @FXML
    private RadioButton cypherRadio;

    @FXML
    private TextField primeTextField;

    @FXML
    private TextField generatorTextField;

    @FXML
    private TextField privateTextField;

    @FXML
    private Button generateButton;

    @FXML
    private TextArea plainArea;

    @FXML
    private TextArea cypherArea;

    @FXML
    private Button encryptButton;

    @FXML
    private Button decryptButton;

    @FXML
    private Button openPlainButton;

    @FXML
    private Button savePlainButton;

    @FXML
    private Button openCypherButton;

    @FXML
    private Button saveCypherButton;

    public MainWindow() {
        cypher = new ElGamal();
        this.stage = new Stage();
        loadScene();
    }

    public void initialize() {
        plainArea.setWrapText(true);
        cypherArea.setWrapText(true);
        stage.setResizable(false);
    }

    public void generate() {
        OurFirstBigInt[] keys = cypher.generateKeys();

        primeTextField.setText(keys[0].toString());
        generatorTextField.setText(keys[1].toString());
        privateTextField.setText(keys[2].toString());
    }

    public void encrypt() throws IOException {

        setKeys();

        if(currentPlainText != null) cypher.setDecrypted(Files.toByteArray(currentPlainText));
        byte[] data = {};
        String encryptContent = plainArea.getText();
        if(cypher.getDecrypted() != null && !plainRadio.isSelected()) {
            data = cypher.getDecrypted();
        }
        else {
            data = encryptContent.getBytes();
        }

        boolean success = cypher.encryptData(data);
        if(success){
            cypherArea.setText(new String(cypher.getEncrypted()));
        } else {
            cypherArea.setText("zle");
        }


    }

    public void decrypt() throws IOException {

        setKeys();

        if(currentCypherText != null) cypher.setEncrypted(Files.toByteArray(currentCypherText));
        byte[] data = {};
        String decryptContent = cypherArea.getText();

        if(cypher.getEncrypted() != null && !cypherRadio.isSelected()) {
                data = cypher.getEncrypted();
        } else {
            data = decryptContent.getBytes();
        }

        boolean success = cypher.decryptData(data);
        byte[] dec = cypher.getDecrypted();
        if(success){
            plainArea.setText(new String(dec));
        } else {
            plainArea.setText("zle");
        }
    }

    public void openPlain() throws IOException {
        currentPlainText = chooser.showOpenDialog(stage);
        if(currentPlainText != null) {
            String content = Files.asCharSource(currentPlainText, Charsets.UTF_8).read();
            plainArea.setText(content);
        }
        if(currentPlainText != null)cypher.setDecrypted(Files.toByteArray(currentPlainText));
    }

    public void savePlain() throws IOException {
        File file = chooser.showSaveDialog(stage);

        if (file != null) {
            //saveTextToFile(plainArea.getText(), file);
            saveBinaryToFile(cypher.getDecrypted(), file);
        }
    }

    public void openCypher() throws IOException {
        currentCypherText = chooser.showOpenDialog(stage);
        if(currentCypherText != null) {
            String content = Files.asCharSource(currentCypherText, Charsets.UTF_8).read();
            cypherArea.setText(content);
        }
        if(currentCypherText != null)cypher.setEncrypted(Files.toByteArray(currentCypherText));

    }

    public void saveCypher() throws IOException {
        File file = chooser.showSaveDialog(stage);

        if (file != null) {
            //saveTextToFile(cypherArea.getText(), file);
            saveBinaryToFile(cypher.getEncrypted(), file);
        }
    }

    private void saveTextToFile(String content, File file) {
        try {
            PrintWriter writer;
            writer = new PrintWriter(file);
            writer.println(content);
            writer.close();
        } catch (IOException ex) {
            Logger.getLogger(MainWindow.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void setKeys() {
        if(primeTextField.getText() != null) {
            cypher.setP(new OurFirstBigInt(primeTextField.getText()));
        } else {
            cypher.setP(null);
        }

        if(generatorTextField.getText() != null) {
            cypher.setG(new OurFirstBigInt(generatorTextField.getText()));
        } else {
            cypher.setG(null);
        }

        if(privateTextField.getText() != null) {
            cypher.setA(new OurFirstBigInt(privateTextField.getText()));
        } else {
            cypher.setA(null);
        }
    }

    private void saveBinaryToFile(byte[] data, File file) throws IOException {
        try (FileOutputStream outputStream = new FileOutputStream(file)) {
            outputStream.write(data);
        }
    }

    private void loadScene() {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("../../../MainWindow.fxml"));
        loader.setController(this);
        try {
            stage.setScene(new Scene(loader.load()));
        } catch (IOException e) {
            e.printStackTrace();
        }
        stage.setTitle("ElGamal Algorithm Example");
    }

    public void show() {
        stage.showAndWait();
    }

}
