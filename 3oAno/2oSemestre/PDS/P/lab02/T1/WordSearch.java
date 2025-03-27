import java.util.Arrays;

public class WordSearch{
    private int side_size;
    private String[] searchWords;
    private char[][] lettersMatrix;

    public WordSearch(char[][] lettersMatrix,int side_size,String[] searchWords){
        this.lettersMatrix = lettersMatrix;
        this.side_size = side_size;
        this.searchWords = searchWords;
    }

    public int getSide_size() {
        return side_size;
    }

    public void setSide_size(int side_size) {
        this.side_size = side_size;
    }

    public String[] getSearchWords() {
        return searchWords;
    }

    public void setSearchWords(String[] searchWords) {
        this.searchWords = searchWords;
    }

    public char[][] getLettersMatrix() {
        return lettersMatrix;
    }

    public void setLettersMatrix(char[][] lettersMatrix) {
        this.lettersMatrix = lettersMatrix;
    } 
}
