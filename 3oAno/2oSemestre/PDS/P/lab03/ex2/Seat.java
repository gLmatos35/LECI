package ex2;

public class Seat {
    private int row;
    private char letter;
    private Classe classe;
    private int numeroReserva;

    public Seat(int row, char letter, Classe classe, int numeroReserva) {
        this.row = row;
        this.letter = letter;
        this.classe = classe;
        this.numeroReserva = numeroReserva;
    }

    public int getRow() {
        return row;
    }

    public char getLetter() {
        return letter;
    }

    public Classe getClasse() {
        return classe;
    }

    public int getNumeroReserva() {
        return numeroReserva;
    }

    @Override
    public String toString() {
        return getRow() + "" + getLetter();
    }
}
