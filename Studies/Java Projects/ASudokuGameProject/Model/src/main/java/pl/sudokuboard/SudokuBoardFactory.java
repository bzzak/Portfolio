package pl.sudokuboard;

public interface SudokuBoardFactory<T> {

    T getFileDao(final String fileName);
}
