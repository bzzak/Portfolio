package pl.sudokuboard;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

public class SudokuBoardDaoFactoryTest {
    public SudokuBoardDaoFactoryTest(){

    }

    @Test
    public void FileSudokuBoardDao(){
        SudokuBoardFactory factory = new SudokuBoardDaoFactory();
        FileSudokuBoardDao dao = (FileSudokuBoardDao) factory.getFileDao("Test.txt");

        assertNotEquals(dao, null);
    }
}
