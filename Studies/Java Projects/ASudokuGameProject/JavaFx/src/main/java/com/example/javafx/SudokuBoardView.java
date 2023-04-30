/**
 * Sample Skeleton for 'SudokuBoardView.fxml' Controller Class
 */

package com.example.javafx;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Pos;
//import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.layout.GridPane;
import javafx.scene.text.Font;
import javafx.stage.Stage;
import pl.sudokuboard.BacktrackingSudokuSolver;
import pl.sudokuboard.GameDifficultyLevel;
import pl.sudokuboard.GameLevel;
import pl.sudokuboard.SudokuBoard;

public class SudokuBoardView {
    private final Stage stage;
    private final SudokuBoard board = new SudokuBoard(new BacktrackingSudokuSolver());

    @FXML // ResourceBundle that was given to the FXMLLoader
    private ResourceBundle resources;

    @FXML // URL location of the FXML file that was given to the FXMLLoader
    private URL location;

    @FXML // fx:id="leftFieldsLabel"
    private Label leftFieldsLabel; // Value injected by FXMLLoader

    @FXML // fx:id="sudokuFields"
    private GridPane sudokuFields; // Value injected by FXMLLoader

    public SudokuBoardView(GameDifficultyLevel gameLevel) {

        this.stage = new Stage();
        this.resources = ResourceBundle.getBundle("bundles.messages");

        board.solveGame();
        GameLevel.setLevel(board, gameLevel);

        FXMLLoader loader = new FXMLLoader(getClass().getResource("/fxml/SudokuBoardView.fxml"));
        loader.setResources(resources);
        loader.setController(this);
        try {
            stage.setScene(new Scene(loader.load()));
        } catch (IOException e) {
            e.printStackTrace();
        }

        if (gameLevel == GameDifficultyLevel.LOW) stage.setTitle(ResourceBundle.getBundle("bundles.messages").getString("board.title.easy"));
        else if (gameLevel == GameDifficultyLevel.MEDIUM) stage.setTitle(ResourceBundle.getBundle("bundles.messages").getString("board.title.normal"));
        else  stage.setTitle(ResourceBundle.getBundle("bundles.messages").getString("board.title.hard"));
        leftFieldsLabel.setText(String.valueOf(gameLevel.getEraseNumber()));
    }

    @FXML
    // This method is called by the FXMLLoader when initialization is complete
    void initialize() {
        fillBoard();
    }

    private void fillBoard() {
        sudokuFields.getChildren().clear();
        for (int row = 0; row < 9; row++) {
            for (int col = 0; col < 9; col++) {
                javafx.scene.control.TextField field = new javafx.scene.control.TextField();
                field.setAlignment(Pos.CENTER);
                field.setFont(new Font("Verdana", 20));
                field.setPrefSize(50, 50);
                field.setText(String.valueOf(board.get(row, col)));
                if (board.get(row, col) != 0) {
                    field.setEditable(false);
                    field.setStyle("-fx-background-color: #81c483;-fx-border-style: solid;");
                } else {
                    field.setStyle("-fx-border-style: solid;");
                    int finalRow = row;
                    int finalCol = col;
                    field.textProperty().addListener((observable, oldValue, newValue) -> {
                        if (!newValue.matches("[0-9]|^$")) {
                            field.setText("");
                        } else if (newValue.matches("[1-9]")) {
                            if (board.correctNumber(finalRow, finalCol,
                                    Integer.parseInt(newValue))) {
                                field.setStyle("-fx-background-color: #81c483"
                                        + ";-fx-border-style: solid;"
                                        + "-fx-border-color: red");
                                leftFieldsLabel.setText(String.valueOf(
                                        Integer.parseInt(leftFieldsLabel.getText()) - 1));
                            }
                            board.set(finalRow, finalCol, Integer.parseInt(newValue));
                        }
                    });
                }

                //boardFields[row][col] = field;
                sudokuFields.add(field, row, col);
            }
        }

    }

    public void show() {
        stage.showAndWait();
    }
}
