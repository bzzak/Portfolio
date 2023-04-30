package pl.sudokuboard;

import java.io.IOException;

public interface Dao<T> extends AutoCloseable {

    T read() throws IOException, ClassNotFoundException;

    boolean write(T obj) throws IOException;
}
//Abstract factory i FACTORY METHOD