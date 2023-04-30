package pl.sudokuboard;

import java.util.List;

/**
 * Element sudoku reprezentuje kolumnę na tablicy sudoku.
 */
public class SudokuColumn extends SudokuBoardElement implements Cloneable {

    /**
     * Tworzy kolumnę sudoku z listy pól sudoku.
     *
     * @param list Lista pól sudoku.
     */
    public SudokuColumn(List<SudokuField> list) {
        super(list);
    }

    @Override
    protected SudokuColumn clone() throws CloneNotSupportedException {
        return (SudokuColumn) super.clone();
    }
}
