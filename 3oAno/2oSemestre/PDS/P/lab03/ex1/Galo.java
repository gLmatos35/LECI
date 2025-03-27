package ex1;

public class Galo implements JGaloInterface {
    private static char player = ' ';
    private char m[];
    private boolean winner = true;
    

    public Galo(char start) {
        m = new char[9];
        for (int i = 0;i<9;i++) {
            m[i] = '.';
        }
        player = start;
    }

    public Galo() {
        this('o');
    }
    @Override
    public char currentPlayer() {
        return player == 'x' ? 'o' : 'x';
    }

    @Override
    public boolean play(int lin, int col) {
        int linha = lin - 1;
        int coluna = col - 1;
        int pos = linha*3+coluna;
        m[pos] = currentPlayer();

        return true;
    }

    public boolean contentIsEqual( int i, int j, int k ) 
    {
        if( m[i] != 0 && m[i] == m[j] && m[j] == m[k] && m[i] != '.') 
        {
            return true;
        }
        return false;
    }

    @Override
    public boolean finished() {

        // em linha
        if ( contentIsEqual(0, 1, 2) || contentIsEqual(3, 4, 5) || contentIsEqual(6, 7, 8) ) return true;

        // em coluna
        if ( contentIsEqual(0, 3, 6) || contentIsEqual(1, 4, 7) || contentIsEqual(2, 5, 8) ) return true;

        // em diagonal
        if ( contentIsEqual(0, 4, 8) || contentIsEqual(2, 4, 6) ) return true;
        
        
        if (player == 'x') {
            player = 'o';
        } else { 
            player = 'x';
        }

        for (int i = 0;i<9;i++) {
            if (m[i] == '.') {
                return false;
            } 
        }

        winner = false;

        return true;


    }

    @Override
    public char result() {
        if (winner == false) {
            return ' ';
        } 
        return currentPlayer();
        
    }
	
}

