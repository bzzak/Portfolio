package pl.sudokuboard;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class SudokuRowTest {

    @Test
    void testClone() {
        SudokuBoard board = new SudokuBoard(new BacktrackingSudokuSolver());
        board.solveGame();
        SudokuRow f1 = board.getRow(1);
        SudokuRow f2 = board.getRow(2);

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