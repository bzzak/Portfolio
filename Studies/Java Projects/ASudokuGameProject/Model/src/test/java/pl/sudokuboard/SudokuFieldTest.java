package pl.sudokuboard;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

/**
 * Testy jednostkowe projektu SudokuBoard.
 */
public class SudokuFieldTest {

    public SudokuFieldTest() {
    }

    @Test
    public void sudokuFieldString(){
        SudokuField f1 = new SudokuField(1);
        SudokuField f2 = new SudokuField(2);
        SudokuField f3 = new SudokuField(3);
        SudokuField f4 = new SudokuField(1);

        assertEquals(f1.toString(), f1.toString());
        assertNotEquals(f1.toString(), f2.toString());
        assertNotEquals(f1.toString(), f3.toString());
        assertNotEquals(f1.toString(), f4.toString());
    }

    @Test
    public void sudokuFieldEquals(){
        SudokuField f1 = new SudokuField(1);
        SudokuField f2 = new SudokuField(2);
        SudokuField f3 = new SudokuField(3);
        SudokuField f4 = new SudokuField(1);
        SudokuField f5 = new SudokuField(1);

        int test = 1;

        assertNotEquals(f1, null);
        assertNotEquals(f1, test);
        assertEquals(f1, f1);
        assertEquals(f1, f1);
        assertNotEquals(f1, f2);
        assertNotEquals(f1, f3);
        assertEquals(f1, f4);
        assertEquals(f4, f5);
        assertEquals(f1, f5);
        assertEquals(f1.equals(f4), f1.hashCode() == f4.hashCode());
    }

    @Test
    public void sudokuFieldHashCode(){
        SudokuField f1 = new SudokuField(1);
        SudokuField f2 = new SudokuField(2);
        SudokuField f3 = new SudokuField(3);
        SudokuField f4 = new SudokuField(1);

        assertEquals(f1.hashCode(), f1.hashCode());
        assertNotEquals(f1.hashCode(), f2.hashCode());
        assertNotEquals(f1.hashCode(), f3.hashCode());
        assertEquals(f1.hashCode(), f4.hashCode());
    }

    @Test
    void compareTo() {
        SudokuField f1 = new SudokuField(1);
        SudokuField f2 = new SudokuField(2);
        SudokuField f3 = new SudokuField(3);
        SudokuField f4 = new SudokuField(1);

        assertEquals(f1.compareTo(f2), -1);
        assertEquals(f1.compareTo(f3), -2);
        assertEquals(f1.compareTo(f4), 0);
        assertEquals(f2.compareTo(f3), -1);
        assertEquals(f2.compareTo(f4), 1);
        assertEquals(f3.compareTo(f4), 2);
        assertThrows(NullPointerException.class, ()->{f1.compareTo(null);});
    }

    @Test
    void testClone() {
        SudokuField f1 = new SudokuField(1);
        SudokuField f2 = new SudokuField(2);

        try {
            SudokuField fc1 = f1.clone();
            SudokuField fc2 = f2.clone();

            assertEquals(f1, fc1);
            assertEquals(f2, fc2);

            assertNotEquals(fc1, f2);
            assertNotEquals(fc2, f1);

            f1.setFieldValue(12);
            f2.setFieldValue(45);
            assertNotEquals(f1, fc1);
            assertNotEquals(f2, fc2);
        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
        }

    }
}


