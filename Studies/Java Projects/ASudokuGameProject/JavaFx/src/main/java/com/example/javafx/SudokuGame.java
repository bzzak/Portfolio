package com.example.javafx;

import java.io.IOException;
import java.util.Locale;

import javafx.application.Application;
import javafx.stage.Stage;

public class SudokuGame extends Application {
    @Override
    public void start(Stage stage) throws IOException {
        //Locale.setDefault(new Locale("en"));
        MainWindow window = new MainWindow();
        window.show();
    }

    public static void main(String[] args) {
        launch();
    }
}