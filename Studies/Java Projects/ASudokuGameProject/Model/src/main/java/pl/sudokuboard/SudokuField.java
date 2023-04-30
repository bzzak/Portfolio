package pl.sudokuboard;

import java.beans.PropertyChangeSupport;
import java.io.Serializable;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;


/**
 * Pole sudoku odpowiada pojedynczemu polu zawierającemu jedną liczbę od 1 do 9.
 */
public class SudokuField implements Serializable, Cloneable, Comparable<SudokuField> {
    private int value;
    private PropertyChangeSupport listener;

    /**
     * Konstruktor bezparametrowy tworzy niewypełnione pole sudoku.
     */
    public SudokuField() {
        this(0);
    }

    /**
     * Konstruktor parometrowy tworzy pole z konkretną wartością.
     *
     * @param v Wartość pola.
     */
    public SudokuField(int v) {
        value = v;
        listener = new PropertyChangeSupport(this);
    }

    /**
     * Zwraca obserwatora tego pola.
     *
     * @return obserwator tego pola.
     */
    public PropertyChangeSupport getListener() {
        return listener;
    }

    /**
     * Zwraca wartość pola sudoku.
     *
     * @return Wartość pola.
     */
    public int getFieldValue() {
        return value;
    }

    /**
     * Ustala wartość pola sudoku.
     *
     * @param v Wartość pola sudoku.
     */
    public void setFieldValue(int v) {
        int oldValue = value;
        value = v;
        if (oldValue != value) {
            listener.firePropertyChange("Field",
                    new SudokuField(oldValue), this);
        }
    }

    /**
     * Zwraca obiekt w postaci łańcucha znaków.
     *
     * @return Obiekt w postaci łańcucha znaków.
     */
    public final String toString() {
        return new ToStringBuilder(this).append("value", value).toString();
    }

    /**
     * Służy do zwrócenia (w miarę) unikalnej wartości
     * liczbowej typu int dla każdego unikalnego obiektu.
     * Jeśli dwa obiekty, których porównanie przy pomocy
     * metody equals() zwraca true, to metoda hashCode()
     * powinna zwracać dla tych obiektów taką samą wartość.
     *
     * @return Unikalna liczba dla tego obiektu.
     */
    public int hashCode() {
        return new HashCodeBuilder(17, 77).append(value).toHashCode();
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

        SudokuField rhs = (SudokuField) obj;
        return new EqualsBuilder().append(value, rhs.value).isEquals();
    }

    @Override
    public int compareTo(SudokuField o) throws NullPointerException {
        if (o == null) {
            throw new NullPointerException();
        }
        return value - o.value;
    }

    @Override
    public SudokuField clone() throws CloneNotSupportedException {
        return (SudokuField) super.clone();
    }


}
