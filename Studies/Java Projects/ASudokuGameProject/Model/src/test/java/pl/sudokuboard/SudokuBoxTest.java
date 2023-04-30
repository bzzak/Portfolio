package pl.sudokuboard;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class SudokuBoxTest {

    @Test
    void testClone() {
        SudokuBoard board = new SudokuBoard(new BacktrackingSudokuSolver());
        board.solveGame();
        SudokuBox f1 = board.getBox(1, 1);
        SudokuBox f2 = board.getBox(5, 1);

        try {
            SudokuBoardElement fc1 = f1.clone();
            SudokuBoardElement fc2 = f2.clone();

            assertEquals(fc1, f1);
            assertEquals(fc2, f2);

            assertNotEquals(fc1, f2);
            assertNotEquals(fc2, f1);

            fc1.setField(12,1);
            fc2.setField(12,1);

            assertNotEquals(fc1, f1);
            assertNotEquals(fc2, f2);

        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
        }
    }
}