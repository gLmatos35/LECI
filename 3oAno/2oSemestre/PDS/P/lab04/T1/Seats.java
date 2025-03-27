public class Seats{
    private int[][] seats;
    private int rows;
    private int cols;

    public Seats(int col, int row){
        this.seats = new int[row][col];
        this.rows = row;
        this.cols = col;
    }

    public void setSeat(int row,int col,int resVal){
        this.seats[row][col] = resVal;
    }

    public int getSeat(int row,int col){
        return this.seats[row][col];
    }

    public int getAvailableSeats(){
        int availSeats = 0;
        for(int i = 0;i<this.cols;i++){
            for(int j = 0;j<this.rows;j++){
                if(this.seats[j][i] == 0){
                    availSeats++;
                }
            }
        }
        return availSeats;
    }

    public int[][] getSeats(){
        return this.seats;
    }

    public void setSeats(int[][] grid){
        this.seats = grid;
    }

    public int getRows(){
        return this.rows;
    }

    public int getCols(){
        return this.cols;
    }

    public int minAvailReserveNum(){  //determinar o primeiro número disponível para reserva
        boolean flag = false;
        for(int i = 1;i<this.cols*this.rows;i++){ //a condição máxima assume reservas individuais para todos os lugares
            flag = false;
            for(int j = 0;j<this.rows;j++){      //procurar os lugares todos
                for(int k = 0;k<this.cols;k++){
                    if(this.seats[j][k] == i){   //se encontrarmos esse numero de reserva então o primeiro livre será maior
                        flag = true;
                        break;
                    }
                }
                if(flag){
                    break;
                }
            }
            if(!flag){
                return i;
            }
        }
        return -1; //in case shit hits the fan

    }

}
