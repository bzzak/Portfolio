/**
 * Sample Skeleton for 'MainWindow.fxml' Controller Class
 */

package com.example.javafx;

import java.io.IOException;
import java.net.URL;
import java.util.Locale;
import java.util.Objects;
import java.util.ResourceBundle;

import javafx.beans.binding.Bindings;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.stage.Stage;
import pl.sudokuboard.GameDifficultyLevel;

public class MainWindow {
    private final Stage stage;
    private GameDifficultyLevel gameLevel = GameDifficultyLevel.LOW;
    private static final ObservableResourceFactory RESOURCE_FACTORY = new ObservableResourceFactory();

    static {
        RESOURCE_FACTORY.setResources(ResourceBundle.getBundle("bundles.messages"));
    }

    @FXML // ResourceBundle that was given to the FXMLLoader
    private ResourceBundle resources;

    @FXML // URL location of the FXML file that was given to the FXMLLoader
    private URL location;

    @FXML
    private ToggleGroup language;

    @FXML
    private ToggleButton english;

    @FXML
    private ToggleButton polish;

    @FXML
    private Label labelGameLevel;

    @FXML
    private Label labelTitle;

    @FXML
    private ComboBox<String> levelComboBox;

    @FXML
    private Button gameStartButton;

    @FXML
    private Button loadButton;

    public MainWindow() {
        this.stage = new Stage();
        this.resources = ResourceBundle.getBundle("bundles.messages");

        FXMLLoader loader = new FXMLLoader(getClass().getResource("/fxml/MainWindow.fxml"));
        loader.setResources(resources);
        loader.setController(this);
        try {
            stage.setScene(new Scene(loader.load()));
        } catch (IOException e) {
            e.printStackTrace();
        }
        stage.titleProperty().bind(RESOURCE_FACTORY.getStringBinding("main.title"));
        labelTitle.textProperty().bind(RESOURCE_FACTORY.getStringBinding("main.title"));
        labelGameLevel.textProperty().bind(RESOURCE_FACTORY.getStringBinding("level.label"));
        gameStartButton.textProperty().bind(RESOURCE_FACTORY.getStringBinding("start.button"));
        loadButton.textProperty().bind(RESOURCE_FACTORY.getStringBinding("load.button"));
    }

    @FXML
    // This method is called by the FXMLLoader when initialization is complete
    void initialize() {
        setData();
        setControlls();
    }

    

    private void setControlls() {
        // action event
        EventHandler<ActionEvent> cbevent = new EventHandler<ActionEvent>() {
            public void handle(ActionEvent e) {
                if (Objects.equals(levelComboBox.getValue(), RESOURCE_FACTORY.getResources().getString("easy"))) {
                    gameLevel = GameDifficultyLevel.LOW;
                } else if (Objects.equals(levelComboBox.getValue(), RESOURCE_FACTORY.getResources().getString("normal"))) {
                    gameLevel = GameDifficultyLevel.MEDIUM;
                } else if (Objects.equals(levelComboBox.getValue(), RESOURCE_FACTORY.getResources().getString("hard"))) {
                    gameLevel = GameDifficultyLevel.HIGH;
                }
            }
        };

        levelComboBox.setOnAction(cbevent);
        gameStartButton.setOnAction(event -> openBoard());
        english.setOnAction(event -> {
            Locale.setDefault(Locale.ENGLISH);
            RESOURCE_FACTORY.setResources(ResourceBundle.getBundle("bundles.messages", Locale.ENGLISH));
            english.setStyle("-fx-background-image: url(/images/great_britain_flag.png);"
                    + " -fx-background-repeat: stretch;"
                    + " -fx-background-size: 50 50;"
                    + " -fx-background-position: center center;"
                    + " -fx-border-width: 3px;"
                    + " -fx-border-color: green");
            polish.setStyle("-fx-background-image: url(/images/polish_flag.png);"
                    + " -fx-background-repeat: stretch;"
                    + " -fx-background-size: 50 50;"
                    + " -fx-background-position: center center");
        });
        polish.setOnAction(event -> {
            Locale.setDefault(Locale.forLanguageTag("pl-PL"));
            RESOURCE_FACTORY.setResources(ResourceBundle.getBundle("bundles.messages", Locale.forLanguageTag("pl-PL")));
            polish.setStyle("-fx-background-image: url(/images/polish_flag.png);"
                    + " -fx-background-repeat: stretch;"
                    + " -fx-background-size: 50 50;"
                    + " -fx-background-position: center center;"
                    + " -fx-border-width: 3px;"
                    + " -fx-border-color: green");
            english.setStyle("-fx-background-image: url(/images/great_britain_flag.png);"
                    + " -fx-background-repeat: stretch;"
                    + " -fx-background-size: 50 50;"
                    + " -fx-background-position: center center");
        });
    }

    private void openBoard() {
        SudokuBoardView boardView = new SudokuBoardView(/*this,*/ gameLevel);
        boardView.show();
    }


    public void setData() {
        levelComboBox.getItems().clear();

        levelComboBox.getItems().addAll(
                RESOURCE_FACTORY.getResources().getString("easy"),
                RESOURCE_FACTORY.getResources().getString("normal"),
                RESOURCE_FACTORY.getResources().getString("hard"));
        levelComboBox.getSelectionModel().select(0);


        if(Locale.getDefault() == Locale.forLanguageTag("pl-PL")) {
            polish.setStyle("-fx-background-image: url(/images/polish_flag.png);"
                    + " -fx-background-repeat: stretch;"
                    + " -fx-background-size: 50 50;"
                    + " -fx-background-position: center center;"
                    + " -fx-border-width: 3px;"
                    + " -fx-border-color: green");
            english.setStyle("-fx-background-image: url(/images/great_britain_flag.png);"
                    + " -fx-background-repeat: stretch;"
                    + " -fx-background-size: 50 50;"
                    + " -fx-background-position: center center");
        } else {
            english.setStyle("-fx-background-image: url(/images/great_britain_flag.png);"
                    + " -fx-background-repeat: stretch;"
                    + " -fx-background-size: 50 50;"
                    + " -fx-background-position: center center;"
                    + " -fx-border-width: 3px;"
                    + " -fx-border-color: green");
            polish.setStyle("-fx-background-image: url(/images/polish_flag.png);"
                    + " -fx-background-repeat: stretch;"
                    + " -fx-background-size: 50 50;"
                    + " -fx-background-position: center center");
        }
    }

    public void show() {
        stage.showAndWait();
    }

}
