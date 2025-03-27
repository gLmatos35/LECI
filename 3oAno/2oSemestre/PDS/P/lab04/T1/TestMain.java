public class TestMain{
    public static void main(String[] args){
        Airplane airplane1 = new Airplane(3,2,10,3);
        Airplane airplane2 = new Airplane(10,4);
        Flight flight1 = new Flight("TP1930",airplane1);
        Flight flight2 = new Flight("TP1920",airplane2);
        System.out.println(flight1.getAirplane().getExecAvailSeats());
        System.out.println(flight2.getAirplane().getExecAvailSeats());
    }
}
