package pl.sudokuboard;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.IOException;

/**
 * Testy jednostkowe projektu SudokuBoard.
 */
public class SudokuBoardTest {

    public SudokuBoardTest() {
    }

    @Test
    public void differentlyFilledBoard() {
        SudokuBoard board = new SudokuBoard(new BacktrackingSudokuSolver());
        board.solveGame();

        SudokuBoard board2 = new SudokuBoard(new BacktrackingSudokuSolver());
        board2.solveGame();

        SudokuBoard board3 = new SudokuBoard(new BacktrackingSudokuSolver());
        board3.solveGame();

        SudokuBoard board4 = new SudokuBoard(new BacktrackingSudokuSolver());
        board4.solveGame();

        SudokuBoard board5 = new SudokuBoard(new BacktrackingSudokuSolver());
        board5.solveGame();


        assertTrue(differentBoards(board,board2));
        assertTrue(differentBoards(board,board3));
        assertTrue(differentBoards(board,board4));
        assertTrue(differentBoards(board,board5));
        assertTrue(differentBoards(board2,board3));
        assertTrue(differentBoards(board2,board4));
        assertTrue(differentBoards(board2,board5));
        assertTrue(differentBoards(board3,board4));
        assertTrue(differentBoards(board3,board5));
    }

    /**
     * Sprawdza, czy algorytm rozwiązuje tablicę Sudoku poprawnie.
     */
    @Test
    public void correctBoard() {
        SudokuBoard board = new SudokuBoard(new BacktrackingSudokuSolver());
        board.solveGame();

        SudokuBoard board2 = new SudokuBoard(new BacktrackingSudokuSolver());
        board2.solveGame();

        SudokuBoard board3 = new SudokuBoard(new BacktrackingSudokuSolver());
        board3.solveGame();

        SudokuBoard board4 = new SudokuBoard(new BacktrackingSudokuSolver());
        board4.solveGame();

        SudokuBoard board5 = new SudokuBoard(new BacktrackingSudokuSolver());
        board5.solveGame();

        assertTrue(correctBoard(board));
        assertTrue(correctBoard(board2));
        assertTrue(correctBoard(board3));
        assertTrue(correctBoard(board4));
        assertTrue(correctBoard(board5));
    }

    /**
     * Sprawdza, czy obserwator poinformuje o źle wypełnionym polu i czy sprawdzanie poprawności tablicy działa.
     */
    @Test
    public void wrongBoardField() {

        SudokuBoard board = new SudokuBoard(new BacktrackingSudokuSolver());
        board.solveGame();

        int value = board.get(0, 0);
        int oldValue = board.get(0, 1);
        board.set(0, 1, value);
        assertEquals(oldValue, board.get(0, 1));
        assertNotEquals(value, board.get(0, 1));
    }

    @Test
    public void sudokuBoardString(){
        SudokuBoard f1 = new SudokuBoard(new BacktrackingSudokuSolver());
        SudokuBoard f2 = new SudokuBoard(new BacktrackingSudokuSolver());
        SudokuBoard f3 = new SudokuBoard(new BacktrackingSudokuSolver());
        SudokuBoard f4 = new SudokuBoard(new BacktrackingSudokuSolver());
        f1.solveGame();
        f2.solveGame();
        f3.solveGame();
        f4.solveGame();

        assertEquals(f1.toString(), f1.toString());
        assertNotEquals(f1.toString(), f2.toString());
        assertNotEquals(f1.toString(), f3.toString());
        assertNotEquals(f1.toString(), f4.toString());
    }

    @Test
    public void sudokuBoardEquals(){
        SudokuBoard f1 = new SudokuBoard(new BacktrackingSudokuSolver());
        SudokuBoard f2 = new SudokuBoard(new BacktrackingSudokuSolver());
        SudokuBoard f3 = new SudokuBoard(new BacktrackingSudokuSolver());
        SudokuBoard f4 = new SudokuBoard(new BacktrackingSudokuSolver());
        f1.solveGame();
        f2.solveGame();
        f3.solveGame();
        f4.solveGame();

        int test = 1;

        assertNotEquals(f1, null);
        assertNotEquals(f1, test);
        assertEquals(f1, f1);
        assertNotEquals(f1, f2);
        assertNotEquals(f1, f3);
        assertNotEquals(f1, f4);
    }

    @Test
    public void sudokuBoardHashCode(){
        SudokuBoard f1 = new SudokuBoard(new BacktrackingSudokuSolver());
        SudokuBoard f2 = new SudokuBoard(new BacktrackingSudokuSolver());
        SudokuBoard f3 = new SudokuBoard(new BacktrackingSudokuSolver());
        SudokuBoard f4 = new SudokuBoard(new BacktrackingSudokuSolver());
        f1.solveGame();
        f2.solveGame();
        f3.solveGame();
        f4.solveGame();

        assertEquals(f1.hashCode(), f1.hashCode());
        assertNotEquals(f1.hashCode(), f2.hashCode());
        assertNotEquals(f1.hashCode(), f3.hashCode());
        assertNotEquals(f1.hashCode(), f4.hashCode());
    }

    private boolean differentBoards(SudokuBoard a, SudokuBoard b) {
        boolean result = false;

        outerloop:
        for (int row = 0; row < a.getBoardSize(); row++) {
            for (int col = 0; col < a.getBoardSize(); col++) {
                if (a.get(col, row) != b.get(col, row)) {
                    result = true;
                    break outerloop;
                }
            }
        }
        return result;
    }

    private boolean correctBoard(SudokuBoard board) {
        boolean result = true;

        for (int i = 0; i < board.getBoardSize(); i++) {
            if (!board.getColumn(i).verify() || !board.getRow(i).verify()) {
                result = false;
                break;
            }
        }

        for (int i = 0; i < board.getBoxSize(); i++) {
            for (int j = 0; j < board.getBoxSize(); j++) {
                if (!board.getBox(i * 3, j * 3).verify()) {
                    result = false;
                    break;
                }
            }
        }
        return result;
    }

    @Test
    void save() {
        String path = "Test.txt";
        File test = new File(path);
        SudokuBoard board = new SudokuBoard(new BacktrackingSudokuSolver());
        board.solveGame();

        assertFalse(test.exists());
        try {
            board.save(path);
        } catch (Exception e) {
            e.printStackTrace();
        }
        assertTrue(test.exists());

        test.delete();
    }

    @Test
    void testClone() {
        SudokuBoard f1 = new SudokuBoard(new BacktrackingSudokuSolver());
        SudokuBoard f2 = new SudokuBoard(new BacktrackingSudokuSolver());
        f1.solveGame();
        f2.solveGame();

        try {
            SudokuBoard fc1 = f1.clone();
            SudokuBoard fc2 = f2.clone();
            assertEquals(f1, fc1);
            assertEquals(f2, fc2);

            assertNotEquals(f1, fc2);
            assertNotEquals(f2, fc1);

            fc1.set(1, 1, -1);
            fc2.set(3, 1, -1);
            assertNotEquals(f1, fc1);
            assertNotEquals(f2, fc2);

        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
        }
        SudokuBoard empty = null;
        assertThrows(CloneNotSupportedException.class, ()->{new SudokuBoard(empty);});
    }

    @Test
    void isSolved() {
        SudokuBoard f1 = new SudokuBoard(new BacktrackingSudokuSolver());
        SudokuBoard f2 = new SudokuBoard(new BacktrackingSudokuSolver());
        SudokuBoard f3 = new SudokuBoard(new BacktrackingSudokuSolver());
        f1.solveGame();
        f2.solveGame();

        assertTrue(f1.isSolved());
        assertTrue(f2.isSolved());
        assertFalse(f3.isSolved());

        f2.set(1, 1, 0);
        assertFalse(f2.isSolved());
    }
}


