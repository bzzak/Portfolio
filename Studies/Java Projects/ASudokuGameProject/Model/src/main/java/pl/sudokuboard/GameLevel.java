package pl.sudokuboard;

import java.util.Random;

public class GameLevel {

    public static void setLevel(SudokuBoard board, GameDifficultyLevel level) {
        if (!board.isSolved()) {
            board.solveGame();
        }

        eraseFields(board, level.eraseNumber);
    }

    private static void eraseFields(SudokuBoard board, int amount) {
        Random rand = new Random();
        int row = rand.nextInt(0,9);
        int col = rand.nextInt(0,9);
        for (int i = 0; i < amount; i++) {
            while (board.get(row, col) == 0) {
                row = rand.nextInt(0,9);
                col = rand.nextInt(0,9);
            }
            board.set(row, col, 0);
        }
    }
}
