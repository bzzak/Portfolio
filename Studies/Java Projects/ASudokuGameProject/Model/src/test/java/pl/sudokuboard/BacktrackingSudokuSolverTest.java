package pl.sudokuboard;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class BacktrackingSudokuSolverTest {

    @Test
    void testHashCode() {
        BacktrackingSudokuSolver s1 = new BacktrackingSudokuSolver();
        BacktrackingSudokuSolver s2 = new BacktrackingSudokuSolver();
        int a = 0;
        assertEquals(s1.hashCode(), s2.hashCode());
        assertEquals(s1.hashCode(), s1.hashCode());
    }

    @Test
    void testEquals() {
        BacktrackingSudokuSolver s1 = new BacktrackingSudokuSolver();
        BacktrackingSudokuSolver s2 = new BacktrackingSudokuSolver();
        int a = 0;
        assertEquals(s1, s2);
        assertEquals(s1, s1);
        assertNotEquals(s1, a);
        assertNotEquals(s1, null);
    }
}