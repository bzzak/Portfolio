package pl.sudokuboard;

import java.util.List;

/**
 * Element sudoku reprezentuje wiersz na tablicy sudoku.
 */
public class SudokuRow extends SudokuBoardElement implements Cloneable {

    /**
     * Tworzy wiersz sudoku z listy pól sudoku.
     *
     * @param list Lista pól sudoku.
     */
    public SudokuRow(List<SudokuField> list) {
        super(list);
    }

    @Override
    protected SudokuRow clone() throws CloneNotSupportedException {
        return (SudokuRow) super.clone();
    }
}
