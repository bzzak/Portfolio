package pl.sudokuboard;

import java.util.List;

/**
 * Element sudoku reprezentuje pudełko na tablicy sudoku.
 */
public class SudokuBox extends SudokuBoardElement implements Cloneable {

    /**
     * Tworzy pudełko sudoku z listy pól sudoku.
     *
     * @param list Lista pól sudoku.
     */
    public SudokuBox(List<SudokuField> list) {
        super(list);
    }

    @Override
    protected SudokuBox clone() throws CloneNotSupportedException {
        return (SudokuBox) super.clone();
    }
}
