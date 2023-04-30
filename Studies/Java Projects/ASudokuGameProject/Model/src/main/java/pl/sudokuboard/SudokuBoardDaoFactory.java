package pl.sudokuboard;

public class SudokuBoardDaoFactory implements SudokuBoardFactory<Dao<SudokuBoard>> {

    public Dao<SudokuBoard> getFileDao(final String fileName) {
        return new FileSudokuBoardDao(fileName);
    }
}
//Fabryka abstrakcyjna i metoda wytwórcza różnica