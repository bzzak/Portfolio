package pl.sudokuboard;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import java.io.*;

import static org.junit.jupiter.api.Assertions.*;

public class FileSudokuBoardDaoTest {

    public FileSudokuBoardDaoTest() {

    }

    @Test
    public void SerializationDeserializationTest() {
        String path = "Test.txt";
        SudokuBoardFactory factory = new SudokuBoardDaoFactory();
        SudokuBoard board = new SudokuBoard(new BacktrackingSudokuSolver());
        SudokuBoard board2 = null;
        board.solveGame();

        try (
                FileSudokuBoardDao dao = (FileSudokuBoardDao) factory.getFileDao(path);
        ) {
            dao.write(board);
            board2 = dao.read();
        } catch (Exception e) {
            e.printStackTrace();
        }

        assertEquals(board.hashCode(), board2.hashCode());
        assertEquals(board, board2);
        File test = new File(path);
        test.delete();
    }
}
