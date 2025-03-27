public class Flight {
    private String code;
    private Airplane airplane;
    private static int reserveNumber;

    public Flight(String code, Airplane airplane) {
        this.code = code;
        this.airplane = airplane;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Airplane getAirplane() {
        return airplane;
    }

    public void setAirplane(Airplane airplane) {
        this.airplane = airplane;
    }

    public int getExecSeats(){
        return this.airplane.getExecAvailSeats();
    }

    public int getTurSeats(){
        return this.airplane.getTurAvailSeats();
    }
    

    public int reserveSeats(String classe, int numSeats){//assumindo que é possível fazer a reserva
        Seats reserveSeats;

        Seats turSeats = this.airplane.getTurSeats();
        Seats execSeats = this.airplane.getExecSeats();

        if(classe.equals("T")){ //determinar seats que vamos reservar
            reserveSeats = turSeats;
        }else if(classe.equals("E")){
            reserveSeats = execSeats;
        }else{
            return -1; //código de erro
        }

        int[][] seatGrid = reserveSeats.getSeats();  //matriz que vamos trabalhar
        Flight.reserveNumber++; //atualizar número de reserva
        
        int[][] newSeatGrid = doReservation(seatGrid,numSeats,reserveSeats.getCols(),reserveSeats.getRows());  //algoritmo de reserva
        
        boolean flag = false;
        for(int i = 0;i<reserveSeats.getRows();i++){  //verificar se existem diferenças do pré e do pós reserva
            for(int j = 0;j<reserveSeats.getCols();j++){
                if(seatGrid[i][j] != newSeatGrid[i][j]){
                    flag = true;
                    break;
                }
            }
            if(flag){
                break;
            }
        }

        if(!flag){  //caso n haja diferenças a reserva n foi efetuada
            Flight.reserveNumber--;  //desfazer número de reserva
            return -2;  //código de erro
        }
        
        if(classe.equals("T")){ //determinar seats que vamos reservar
            turSeats.setSeats(newSeatGrid);
            airplane.setTurSeats(turSeats);
        }else if(classe.equals("E")){
            execSeats.setSeats(newSeatGrid);
            airplane.setExecSeats(execSeats);
        }else{
            return -3; //código de erro
        }

        setAirplane(airplane);
        
        return Flight.reserveNumber;   // meti 1 pra poder correr o codigo
    }
    
    public int[][] doReservation(int[][] seatGrid,int numSeats,int cols,int rows){ //para numSeats >= rows
        boolean flag = true;
        for(int i = 0;i<cols;i++){
            flag = true;
            for(int j = 0;j<rows;j++){
                if(seatGrid[j][i] != 0){  //fila não é livre
                    flag = false;
                    break;
                }
            }
            if(flag){  //preencher fila encontrada com reserva
                for(int k = 0;k<rows;k++){
                    seatGrid[k][i] = Flight.reserveNumber;
                }
                //repeat process for remaining seats
                numSeats = numSeats - rows; //lugares que faltam reservar
                if(numSeats < rows){  //não continuamos no loop de reservas de linha
                    break;
                }
            }   
        }
        //reserva manual dos restantes
        for(int i = 0;i<cols;i++){
            for(int j = 0;j<rows;j++){
                if(seatGrid[j][i] == 0){ //reservar se estiver livre
                    seatGrid[j][i] = Flight.reserveNumber;
                    numSeats--;
                    if(numSeats == 0){
                        flag = true;
                        break;
                    }
                }
            }
            if(flag){
                break;
            }
        }

        if(numSeats > 0){ //if not all reserved, undo process
            for(int i = 0;i<cols;i++){
                for(int j = 0;j<rows;j++){
                    if(seatGrid[j][i] == Flight.reserveNumber){ //reservar se estiver livre
                        seatGrid[j][i] = 0;
                    }
                }
            }
        }

        return seatGrid;
    }

    public boolean cancelReservation(int reserveNum){ //se por alguma razão os getters falharem ele devolve false
        Airplane airplane = this.getAirplane();
        Seats turSeats = airplane.getTurSeats();
        Seats execSeats = airplane.getExecSeats();

        if(airplane == null || turSeats == null){
            return false;
        }

        if(execSeats != null){
            int[][] execGrid = execSeats.getSeats();
            if(execGrid == null){
                return false;
            }
            for(int i = 0;i<execSeats.getRows();i++){
                for(int j = 0;j<execSeats.getCols();j++){
                    if(execGrid[i][j] == reserveNum){
                        execGrid[i][j] = 0;
                    }
                }
            }
            execSeats.setSeats(execGrid);
            airplane.setExecSeats(execSeats);
        }

        int[][] turGrid = turSeats.getSeats();
        if(turGrid == null){
            return false;
        }
        for(int i = 0;i<execSeats.getRows();i++){
            for(int j = 0;j<execSeats.getCols();j++){
                if(turGrid[i][j] == reserveNum){
                    turGrid[i][j] = 0;
                }
            }
        }
        
        turSeats.setSeats(turGrid);
        airplane.setTurSeats(turSeats);
        setAirplane(airplane); //é basicamente um big método setter
        
        return true;
    }



    @Override
    public String toString() {  // TO DO: Vasco
        // P flight_code: exibe o plano das reservas de um voo, conforme mostra o exemplo.
        // Os lugares reservados são identificados pelo número sequencial da reserva; os lugares
        // livres são identificados pelo número 0.
        // Exemplo de execução:
        // Escolha uma opção: (H para ajuda)
        // P TP1920
        // 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18
        // A 3 3 5 1 2 2 4 0 0 0 0 0 0 0 0 0 0 0
        // B 3 6 5 1 2 0 0 0 0 0 0 0 0 0 0 0 0 0
        // C 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0

        String result = "";

        // ciclo for: result += qualquer coisa
        Seats execSeats = this.airplane.getExecSeats();
        Seats turSeats = this.airplane.getTurSeats();
        int execWidth = 0;
        int execHeight = 0;

        if(execSeats != null){
            int[][] execGrid = execSeats.getSeats();  
            execWidth = execSeats.getCols();  
            execHeight = execSeats.getRows();
        }
        
        int[][] turGrid = turSeats.getSeats();
        int turWidth = turSeats.getCols();
        int turHeight = turSeats.getRows();
        
        int fullWidth = execWidth+turWidth;
        int maxHeight = Math.max(execHeight,turHeight);
        //primeira linha
        System.out.print("   ");
        for(int i = 1;i<=fullWidth;i++){
            System.out.printf("%3d",i);
        }
        System.out.println();
        //linhas subsequentes
        int letter = 'A';
        for(int i = 0;i<maxHeight;i++){
            System.out.printf("%3s",letter);
            letter++;
            if(execSeats != null){
                if(i<=maxHeight){
                    for(int j = 0;j<execWidth;j++){
                        System.out.printf("%3d",execGrid[i][j]);
                    }   
                }else{
                    for(int j = 0;j<execWidth;j++){
                        System.out.print("   ");
                    }
                }
            }
        }
        return result;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((code == null) ? 0 : code.hashCode());
        result = prime * result + ((airplane == null) ? 0 : airplane.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Flight other = (Flight) obj;
        if (code == null) {
            if (other.code != null)
                return false;
        } else if (!code.equals(other.code))
            return false;
        if (airplane == null) {
            if (other.airplane != null)
                return false;
        } else if (!airplane.equals(other.airplane))
            return false;
        return true;
    }

    
}
