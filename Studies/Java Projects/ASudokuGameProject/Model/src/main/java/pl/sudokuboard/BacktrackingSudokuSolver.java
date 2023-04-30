package pl.sudokuboard;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;

/**
 * Rozwiązuje tablicę Sudoku za pomocą algorytmu Backtracking.
 */
public class BacktrackingSudokuSolver implements SudokuSolver, Cloneable {
    private static final List<Integer> allowedNumbers
            = List.of(1, 2, 3, 4, 5, 6, 7, 8, 9);

    /**
     * Rozwiązuje tablicę Sudoku.
     *
     * @param board Tablica do rozwiązania.
     */
    @Override
    public void solve(SudokuBoard board) {
        for (int row = 0; row < board.getBoardSize(); row++) {
            int failures = 0;
            while (!solveRow(board, row)) {
                cleanRow(board, row);
                failures++;
                if (failures > 20) {
                    row = 0;
                }
            }
        }
    }

    /**
     * Rozwiązuje konkretny wiersz tablicy Sudoku.
     *
     * @param board Tablica do rozwiązania.
     * @param row   Numer wiersza do rozwiązania.
     * @return True, jeśli udało się rozwiązać wiersz.
     */
    private boolean solveRow(SudokuBoard board, int row) {
        List<Integer> currentNumbers = generateAllowedNumbers();

        for (int col = 0; col < board.getBoardSize(); col++) {
            boolean inserting = true;
            int currentIndex = 0;
            int inserts = 0;
            while (inserting) {
                if (board.correctNumber(row, col, currentNumbers.get(currentIndex))) {
                    board.set(row, col, currentNumbers.get(currentIndex));
                    currentNumbers.remove(currentIndex);
                    currentIndex--;
                    inserting = false;
                    inserts--;
                }
                inserts++;
                currentIndex++;
                if (currentIndex >= currentNumbers.size()) {
                    currentIndex = 0;
                }

                if (inserts > board.getBoardSize()) {
                    return false;
                }
            }
        }
        return true;
    }

    /**
     * Miesza kolejność i zwraca dozwolone wartości dla pola tablicy Sudoku.
     *
     * @return Pomieszane, dozwolone wartości tablicy Sudoku.
     */
    private ArrayList<Integer> generateAllowedNumbers() {
        ArrayList<Integer> list = new ArrayList<>(allowedNumbers);
        Collections.shuffle(list);
        return list;
    }

    /**
     * Wyczyszcza wiersz tablicy Sudoku.
     *
     * @param board Tablica Sudoku.
     * @param row   Numer wiersza do wyczyszczenia.
     */
    private void cleanRow(SudokuBoard board, int row) {
        for (int i = 0; i < board.getBoardSize(); i++) {
            board.set(row, i, 0);
        }
    }

    /**
     * Służy do zwrócenia (w miarę)
     * unikalnej wartości liczbowej typu int dla każdego unikalnego obiektu.
     * Jeśli dwa obiekty, których
     * porównanie przy pomocy metody equals() zwraca true, to metoda hashCode()
     * powinna zwracać dla tych obiektów taką samą wartość.
     *
     * @return Unikalna liczba dla tego obiektu.
     */
    public int hashCode() {
        return new HashCodeBuilder(17, 77)
                .toHashCode();
    }

    /**
     * Sprawdza, czy podany obiekt jest równy temu obiektowi.
     *
     * @param obj Obiekt do porównania.
     * @return True, jeśli obiekt jest tej samej klasy i ma te same wartości w składowych.
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        return new EqualsBuilder()
                .isEquals();
    }

    @Override
    public BacktrackingSudokuSolver clone() throws CloneNotSupportedException {
        return (BacktrackingSudokuSolver) super.clone();
    }
}
