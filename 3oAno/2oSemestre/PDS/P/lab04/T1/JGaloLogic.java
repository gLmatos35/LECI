//PDS, lab03

public class JGaloLogic implements JGaloInterface{
    private char player = 'O';
    private char[][] play = new char[3][3];
    private boolean[][] checked = new boolean[3][3];
    private char result = ' ';

    public char currentPlayer(){
        return this.player;
    }

    public void setPlayer(char p){
        this.player = p;
    }

    public void changePlayer(){
        if(this.player == 'X'){
            //System.out.println("Jogador O");
            setPlayer('O');
        }else{
            //System.out.println("Jogador X");
            setPlayer('X');
        }
    }

    public boolean play(int lin, int col){
        int coord = (lin - 1) * 3 + col;  //transform coords into 0-8 value
        this.play[lin-1][col-1] = this.currentPlayer();
        this.checked[lin-1][col-1] = true;
        this.changePlayer();
        return true;
    }

    public boolean finished(){
        //verificar se existem 3 em linha
        for(int i = 0;i<3;i++){  //testar para ver se existem 3 em linha
                                 //é brute force tho
            for(int j = 0;j<3;j++){
                if(threeInLine(play,i,j)){
                    //System.out.println("Há linha");
                    return true;
                }
            }
        }

        //verificar se está tudo jogado
        for(int i = 0;i<3;i++){
            for(int j = 0;j<3;j++){
               if(!checked[i][j]){ //se não estiver jogado então não acabou
                    //System.out.println("Não está tudo jogado");
                    return false;
                }
            }
        }
        System.out.println("Acabou");
        return true;

    }

    private boolean threeInLine(char[][] grid,int x,int y){
        char initChar = grid[x][y];
        if(initChar == '\u0000'){ return false; }  //'\u0000' é unicode para
                                                   //o char default ao inicializar
                                                   //um array de char
        if(x == 0 && y == 0){  //verificar canto superior esquerdo
            if(grid[0][1] == initChar && grid[0][2] == initChar){
                this.result = initChar;
                //System.out.println("Vertical esquerda");
                return true;
            }else if(grid[1][1] == initChar && grid[2][2] == initChar){
                //System.out.println("Diagonal principal");
                this.result = initChar;
                return true;
            }else if(grid[1][0] == initChar && grid[2][0] == initChar){
                this.result = initChar;
                //System.out.println("Horizontal superior");
                return true;
            }
        }else if(x == 2 && y == 0){  //verificar canto superior direito
            if(grid[2][1] == initChar && grid[2][2] == initChar){
                this.result = initChar;
                //System.out.println("Vertical direita");
                return true;
            }else if(grid[1][1] == initChar && grid[0][2] == initChar){
                this.result = initChar;
                //System.out.println("Diagonal secundária");
                return true;
            }
        }else if(x == 0 && y == 1){  //verificar horizontal do meio
            if(grid[1][1] == initChar && grid[2][1] == initChar){
                this.result = initChar;
                //System.out.println("Horizontal do meio");
                return true;
            }
        }else if(x == 0 && y == 2){  //verificar horizontal de baixo
            if(grid[1][2] == initChar && grid[2][2] == initChar){
                this.result = initChar;
                //System.out.println("Horizontal do meio");
                return true;
            }
        }else if(x == 1 && y == 0){  //verificar vertical do meio
            if(grid[1][1] == initChar && grid[1][2] == initChar){
                this.result = initChar;
                //System.out.println("Horizontal do meio");
                return true;
            }
        }
        //System.out.println("Não há linha");
        return false;
    }

    public char result(){
        return this.result;
    }                                   // who won?
}
