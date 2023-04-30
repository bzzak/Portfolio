package pl.sudokuboard;

import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;

/**
 * Klasa implementująca tablicę Sudoku.
 */
public class SudokuBoard implements PropertyChangeListener, Serializable, Cloneable {
    private final int boardSize = 9;
    private final int boxSize = 3;

    private final SudokuSolver solver;
    private final SudokuField[][] board = new SudokuField[boardSize][boardSize];

    /**
     * Tworzy tablicę sudoku.
     *
     * @param solver Algorytm rozwiązujący tablicę sudoku.
     */
    public SudokuBoard(SudokuSolver solver) {
        this.solver = solver;

        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                board[i][j] = new SudokuField();
                board[i][j].getListener().addPropertyChangeListener(this);
            }
        }
    }

    public SudokuBoard(SudokuBoard target) throws CloneNotSupportedException {
        if (target == null) {
            throw new CloneNotSupportedException();
        }

        this.solver = target.solver.clone();
        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                board[i][j] = target.board[i][j].clone();
                board[i][j].getListener().addPropertyChangeListener(this);
            }
        }
    }

    /**
     * Rozwiązuje tablicę Sudoku.
     */
    public void solveGame() {
        this.solver.solve(this);
    }

    /**
     * Sprawdza poprawność tablicy. Niewypełniona tablica jest wciąż poprawna.
     *
     * @return True, jeśli tablica jest poprawna.
     */
    private boolean checkBoard() {

        boolean result = true;
        for (int row = 0; row < boardSize; row++) {
            SudokuRow r = getRow(row);
            result &= r.verify();
        }

        for (int col = 0; col < boardSize; col++) {
            SudokuColumn c = getColumn(col);
            result &= c.verify();
        }


        for (int row = 0; row < boxSize; row++) {
            for (int col = 0; col < boxSize; col++) {
                SudokuBox b = getBox(row * 3, col * 3);
                result &= b.verify();
            }
        }
        return result;
    }

    /**
     * Zwraca wiersz o podanym numerze.
     *
     * @param number Numer wiersza.
     * @return Wiersz tablicy Sudoku — SudokuRow.
     */
    public SudokuRow getRow(int number) {
        List<SudokuField> list = new ArrayList<>();
        for (int i = 0; i < boardSize; i++) {
            list.add(new SudokuField(board[number][i].getFieldValue()));
        }
        return new SudokuRow(list);
    }

    /**
     * Zwraca kolumnę o podanym numerze.
     *
     * @param number Numer kolumny.
     * @return Kolumna tablicy Sudoku — SudokuColumn.
     */
    public SudokuColumn getColumn(int number) {
        List<SudokuField> list = new ArrayList<>();
        for (int i = 0; i < boardSize; i++) {
            list.add(new SudokuField(board[i][number].getFieldValue()));
        }
        return new SudokuColumn(list);
    }

    /**
     * Na podstawie konkretnego pola, zwraca kwadrat o boku 3, do którego to pole należy.
     *
     * @param row Numer wiersza pola.
     * @param col Numer kolumny pola.
     * @return SudokuBox, do którego to pole należy.
     */
    public SudokuBox getBox(int row, int col) {
        col = col / boxSize;
        row = row / boxSize;
        List<SudokuField> list = new ArrayList<>();

        for (int i = 0; i < boxSize; i++) {
            for (int j = 0; j < boxSize; j++) {
                int r = boxSize * row + i;
                int c = col * boxSize + j;
                list.add(new SudokuField(board[r][c].getFieldValue()));
            }
        }
        return new SudokuBox(list);
    }

    /**
     * Zwraca wartość konkretnego pola tablicy Sudoku.
     *
     * @param row Numer wiersza pola.
     * @param col Numer kolumny pola.
     * @return Wartość pola.
     */
    public int get(int row, int col) {
        return board[row][col].getFieldValue();
    }

    /**
     * Zwraca rozmiar boku tablicy Sudoku.
     *
     * @return Rozmiar boku tablicy Sudoku.
     */
    public int getBoardSize() {
        return boardSize;
    }

    /**
     * Zwraca rozmiar boku kwadratu Sudoku.
     *
     * @return Rozmiar boku kwadratu Sudoku.
     */
    public int getBoxSize() {
        return boxSize;
    }

    /**
     * Ustala wartość konkretnego pola.
     *
     * @param row   Numer wiersza pola.
     * @param col   Numer kolumny pola.
     * @param value Nowa wartość pola.
     */
    public void set(int row, int col, int value) {
        board[row][col].setFieldValue(value);
    }

    /**
     * Sprawdza, czy podany numer może zostać wstawiony w konkretne pole tablicy Sudoku.
     *
     * @param row   Numer wiersza pola do sprawdzenia.
     * @param col   Numer kolumny pola do sprawdzenia.
     * @param value Wartość, jaka ma być wstawiona.
     * @return True, jeśli można wstawić wartość.
     */
    public boolean correctNumber(int row, int col, int value) {
        boolean result = correct(getColumn(col), value);
        result &= correct(getRow(row), value);
        result &= correct(getBox(row, col), value);
        return result;
    }

    /**
     * Sprawdza, czy można wstawić podaną wartość do elementu tablicy Sudoku.
     *
     * @param element Element tablicy.
     * @param value   Wartość do sprawdzenia.
     * @return True, jeśli można wstawić wartość.
     */
    private boolean correct(SudokuBoardElement element, int value) {
        for (int i = 0; i < boardSize; i++) {
            if (element.getFieldValue(i) == value) {
                return false;
            }
        }
        return true;
    }

    /**
     * Funkcja wywoływana w przypadku spełnienia warunków obserwatora (zmiana jest niepoprawna).
     *
     * @param evt Obiekt z informacjami o zmianie pola.
     */
    @Override
    public void propertyChange(PropertyChangeEvent evt) {
        if (!checkBoard()) {
            ((SudokuField) evt.getNewValue())
                    .setFieldValue(((SudokuField) evt.getOldValue()).getFieldValue());
        }
    }

    /**
     * Zwraca obiekt w postaci łańcucha znaków.
     *
     * @return Obiekt w postaci łańcucha znaków.
     */
    public final String toString() {
        return new ToStringBuilder(this)
                .append("boardSize", boardSize)
                .append("boxSize", boxSize)
                .append("solver", solver)
                .append("board", board)
                .toString();
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
                .append(boardSize)
                .append(boxSize)
                .append(solver)
                .append(board)
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

        SudokuBoard that = (SudokuBoard) obj;

        return new EqualsBuilder()
                .append(boardSize, that.boardSize)
                .append(boxSize, that.boxSize)
                .append(solver, that.solver)
                .append(board, that.board)
                .isEquals();
    }

    @Override
    protected SudokuBoard clone() throws CloneNotSupportedException {
        return new SudokuBoard(this);
    }

    public void save(String fileName) throws Exception {
        SudokuBoardFactory<Dao<SudokuBoard>> factory = new SudokuBoardDaoFactory();
        try (
                FileSudokuBoardDao dao = (FileSudokuBoardDao) factory.getFileDao(fileName);
        ) {
            dao.write(this);
        }
    }

    public boolean isSolved() {
        for (int row = 0; row < boardSize; row++) {
            for (int col = 0; col < boardSize; col++) {
                if (board[row][col].getFieldValue() == 0) {
                    return false;
                }
            }
        }

        return checkBoard();
    }
}
