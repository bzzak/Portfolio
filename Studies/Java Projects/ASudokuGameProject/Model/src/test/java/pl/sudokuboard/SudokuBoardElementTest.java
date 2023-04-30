package pl.sudokuboard;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;



/**
 * Testy jednostkowe projektu SudokuBoard.
 */
public class SudokuBoardElementTest {

    /**
     * Uruchamia wszystkie testy.
     */
    public SudokuBoardElementTest() {
    }

    @Test
    public void sudokuBoardElementString(){
        SudokuBoard board = new SudokuBoard(new BacktrackingSudokuSolver());
        board.solveGame();
        SudokuBoardElement f1 = board.getRow(1);
        SudokuBoardElement f2 = board.getRow(2);
        SudokuBoardElement f3 = board.getRow(3);
        SudokuBoardElement f4 = board.getRow(1);

        assertEquals(f1.toString(), f1.toString());
        assertNotEquals(f1.toString(), f2.toString());
        assertNotEquals(f1.toString(), f3.toString());
        assertNotEquals(f1.toString(), f4.toString());
    }

    @Test
    public void sudokuBoardElementEquals(){
        SudokuBoard board = new SudokuBoard(new BacktrackingSudokuSolver());
        board.solveGame();
        SudokuBoardElement f1 = board.getRow(1);
        SudokuBoardElement f2 = board.getRow(2);
        SudokuBoardElement f3 = board.getRow(3);
        SudokuBoardElement f4 = board.getRow(1);
        SudokuBoardElement f5 = board.getRow(1);

        int test = 1;

        assertNotEquals(f1, null);
        assertNotEquals(f1, test);
        assertEquals(f1, f1);
        assertEquals(f1, f1);
        assertNotEquals(f1, f2);
        assertNotEquals(f1, f3);
        assertEquals(f1, f4);
        assertEquals(f4, f5);
        assertEquals(f1, f5);
        assertEquals(f1.equals(f4), f1.hashCode() == f4.hashCode());
    }

    @Test
    public void sudokuBoardElementHashCode(){
        SudokuBoard board = new SudokuBoard(new BacktrackingSudokuSolver());
        board.solveGame();
        SudokuBoardElement f1 = board.getRow(1);
        SudokuBoardElement f2 = board.getRow(2);
        SudokuBoardElement f3 = board.getRow(3);
        SudokuBoardElement f4 = board.getRow(1);

        assertEquals(f1.hashCode(), f1.hashCode());
        assertNotEquals(f1.hashCode(), f2.hashCode());
        assertNotEquals(f1.hashCode(), f3.hashCode());
        assertEquals(f1.hashCode(), f4.hashCode());
    }

    @Test
    void testClone() {
        SudokuBoard board = new SudokuBoard(new BacktrackingSudokuSolver());
        board.solveGame();
        SudokuBoardElement f1 = board.getRow(1);
        SudokuBoardElement f2 = board.getRow(2);

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


