public class Airplane {
    private Seats turSeats;
    private Seats execSeats;

    public Airplane(int colExec,int rowExec,int colTur,int rowTur){
        this.turSeats = new Seats(colTur,rowTur);
        this.execSeats = new Seats(colExec,rowExec);
    }

    public Airplane(int colTur, int rowTur){
        this.turSeats = new Seats(colTur,rowTur);
    }

    public int getExecAvailSeats(){
        if(execSeats != null){
            return execSeats.getAvailableSeats();
        }else{
            return -1;
        }
    }
    
    public Seats getTurSeats(){
        return this.turSeats;
    }
    
    public Seats getExecSeats(){
        return this.execSeats;
    }

    public void setExecSeats(Seats obj){
        this.execSeats = obj;
    }

    public void setTurSeats(Seats obj){
        this.turSeats = obj;
    }

    public int getTurAvailSeats(){
        return turSeats.getAvailableSeats();
    }
}
