package pl.sudokuboard;

import java.util.Arrays;
import java.util.List;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;



/**
 * Element sudoku jest wspólną klasą dla wiersza, kolumny i pudełka na tablicy sudoku.
 */
public class SudokuBoardElement implements Cloneable {
    private final int size = 9;
    private List<SudokuField> fields = Arrays.asList(new SudokuField[size]);

    /**
     * Tworzy element sudoku z listy pól sudoku.
     *
     * @param list Lista pól sudoku.
     */
    public SudokuBoardElement(List<SudokuField> list) {
        for (int i = 0; i < size; i++) {
            fields.set(i, list.get(i));
        }
    }

    /**
     * Zwraca wartość konkretnego pola.
     *
     * @param number Numer pola.
     * @return Wartość wskazanego pola.
     */
    public int getFieldValue(int number) {
        return fields.get(number).getFieldValue();
    }

    public void setField(int fieldValue, int index) {
        fields.get(index).setFieldValue(fieldValue);
    }

    /**
     * Weryfikuję poprawność elementu tablicy sudoku.
     *
     * @return True, jeśli element tablicy sudoku jest poprawny.
     */
    public boolean verify() {
        int[] values = new int[size];
        int index;

        for (int i = 0; i < size; i++) {
            index = fields.get(i).getFieldValue() - 1;
            // Pole niewypełnione.
            if (index < 0) {
                continue;
            }
            values[index]++;
            if (values[index] > 1) {
                return false;
            }
        }
        return true;
    }

    /**
     * Zwraca obiekt w postaci łańcucha znaków.
     *
     * @return Obiekt w postaci łańcucha znaków.
     */
    public final String toString() {
        return new ToStringBuilder(this)
                .append("fields", fields)
                .append("size", size)
                .toString();
    }

    /**
     * Służy do zwrócenia (w miarę) unikalnej
     * wartości liczbowej typu int dla każdego unikalnego obiektu.
     * Jeśli dwa obiekty, których porównanie
     * przy pomocy metody equals() zwraca true, to metoda hashCode()
     * powinna zwracać dla tych obiektów taką samą wartość.
     *
     * @return Unikalna liczba dla tego obiektu.
     */
    public int hashCode() {
        return new HashCodeBuilder(17, 77)
                .append(fields)
                .append(size)
                .toHashCode();
    }

    /**
     * Sprawdza, czy podany obiekt jest równy temu obiektowi.
     *
     * @param obj Obiekt do porównania.
     * @return True, jeśli obiekt jest tej samej klasy i ma te same wartości w składowych.
     */
    public boolean equals(final Object obj) {
        if (obj == null) {
            return false;
        }
        if (obj == this) {
            return true;
        }
        if (obj.getClass() != getClass()) {
            return false;
        }

        SudokuBoardElement rhs = (SudokuBoardElement) obj;
        return new EqualsBuilder()
                .append(fields, rhs.fields)
                .append(size, rhs.size)
                .isEquals();
    }

    @Override
    protected SudokuBoardElement clone() throws CloneNotSupportedException {
        SudokuBoardElement element = (SudokuBoardElement) super.clone();
        element.fields = Arrays.asList(new SudokuField[size]);
        for (int i = 0; i < size; i++) {
            element.fields.set(i, new SudokuField(fields.get(i).getFieldValue()));
        }
        return element;
    }

}
