public class Tabuleiro {

    char[][] grid;
    
    public Tabuleiro() {
        this.grid = new char[3][3];
    }

    public char[][] getGrid() {
      return this.grid;
    }
    public void setGrid(char[][] value) {
      this.grid = value;
    }

    public void jogar(int row,int col,char player){
        grid[row-1][col-1] = player;
    }

    public boolean checkWin(char player){

        // linhas e colunas
        for(int i = 0;i<3;i++){
            if((grid[i][0]==player && grid[i][1]==player && grid[i][2] == player) || 
            grid[0][i] == player && grid[1][i]==player && grid[2][i] == player){
                return true;
            }
        }

        //diagonais
        if((grid[0][0] == player && grid[1][1] == player && grid[2][2] == player) ||
        grid[0][2] == player && grid[1][1] == player && grid[2][0] == player){
            return true;
        }

        return false;


    }


    public boolean isBoardFull() {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (grid[i][j] == '\0') return false;
            }
        }
        return true;
    }


    public boolean jogadaValida(int row,int col){
        if(row < 1 || col > 3){
            return false;
        }
        if(col < 1 || col > 3){
            return false;
        }
        if(grid[row-1][col-1] != '\0'){
            return false;
        }
        return true;
    }

}
