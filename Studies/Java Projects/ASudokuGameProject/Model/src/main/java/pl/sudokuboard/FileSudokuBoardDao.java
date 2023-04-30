package pl.sudokuboard;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

public class FileSudokuBoardDao implements Dao<SudokuBoard>, AutoCloseable {
    String fileName;

    public FileSudokuBoardDao(final String fileName) {
        this.fileName = fileName;
    }

    public SudokuBoard read() throws IOException, ClassNotFoundException {
        SudokuBoard sudokuBoard = null;

        try (
                FileInputStream fis = new FileInputStream(fileName);
                ObjectInputStream ois = new ObjectInputStream(fis);
        ) {
            sudokuBoard = (SudokuBoard) ois.readObject();
        }

        return sudokuBoard;
    }

    public boolean write(final SudokuBoard sudokuBoard) throws IOException {
        try (
                FileOutputStream fos = new FileOutputStream(fileName);
                ObjectOutputStream oos = new ObjectOutputStream(fos)
        ) {
            oos.writeObject(sudokuBoard);
        }
        return true;
    }

    @Override
    public void close() throws Exception {
    }
}
