package pl.sudokuboard;

public enum GameDifficultyLevel {
    LOW(10),
    MEDIUM(30),
    HIGH(60);

    int eraseNumber;

    public int getEraseNumber() {
        return eraseNumber;
    }

    GameDifficultyLevel(int eraseNumber) {
        this.eraseNumber = eraseNumber;
    }
}
