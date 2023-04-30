package pl.sudokuboard;

import java.io.Serializable;

/**
 * Interfejs klas rozwiązujących tablicę Sudoku.
 */
public interface SudokuSolver extends Serializable, Cloneable {
    /**
     * Rozwiązuje tablicę Sudoku.
     *
     * @param board Tablica do rozwiązania.
     */
    void solve(SudokuBoard board);

    SudokuSolver clone() throws CloneNotSupportedException;
}
