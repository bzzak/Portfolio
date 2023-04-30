package pl.sudokuboard;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class GameLevelTest {

    @Test
    void setLevel() {
        SudokuBoard f1 = new SudokuBoard(new BacktrackingSudokuSolver());
        SudokuBoard f2 = new SudokuBoard(new BacktrackingSudokuSolver());
        SudokuBoard f3 = new SudokuBoard(new BacktrackingSudokuSolver());
        f1.solveGame();
        f2.solveGame();

        assertTrue(f1.isSolved());
        GameLevel.setLevel(f1, GameDifficultyLevel.LOW);
        assertFalse(f1.isSolved());

        assertTrue(f2.isSolved());
        GameLevel.setLevel(f2, GameDifficultyLevel.HIGH);
        assertFalse(f2.isSolved());

        assertFalse(f3.isSolved());
        GameLevel.setLevel(f2, GameDifficultyLevel.MEDIUM);
        assertFalse(f3.isSolved());

        GameLevel l = new GameLevel();
    }
}