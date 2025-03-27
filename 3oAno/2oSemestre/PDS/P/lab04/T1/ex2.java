import java.util.HashMap;
import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;

public class ex2 {
    public static void main(String[] args) {
        //ArrayList<Flight> flights = new ArrayList<>();
        HashMap<String, Flight> flights = new HashMap<>();

        // Variable initialization
        String filename;
        String flight_code;
        String classe;  // class is a reserved token, therefore 'classe'
        int number_seats;
        int reservation_code;
        Flight flight;

        Scanner sc = new Scanner(System.in);
        while (true) {

            System.out.println("\nEnter a command: (H for help)");
            System.out.print("Command: ");
            //String input = sc.nextLine().strip();
            String input = sc.nextLine().strip();

            //String flight_code;
            UI ui = new UI();
            // fazer parse do comando, validar inputs e retornar esses inputs do género String[] args 
            String[] command_args = ui.isValidInput(input);
            
            // System.out.println("START");
            // for (String st : command_args) {
            //     System.out.printf("String: %s (%d)\n", st, st.length());
            // }
            // System.out.println("END");

            // UI ui = new UI();
            // String[] command_args = {"R", "flight1k.txt"};

            try {
                String command_type = command_args[0];

                switch(command_type) {  //avaliação de cada código
                    case "H":  //H
                        ui.listMenuOptions();
                        break;

                    case "R":  //R
                        filename = command_args[1];

                        //lógica para criar voo
                            //funçao que aceita nome de ficheiro e retorna voo ou null
                        //lógica para definir reservas
                            //se o voo for null não fazer reservas
                            //se não der para fazer uma certa reserva avançar para a seguinte

                        flight = readFile(filename);

                        if (flight != null) {
                            flights.put(flight.getCode(), flight);
                        }

                        break;

                    case "P":  //P
                        flight_code = command_args[1];
                        //lógica do print do voo

                        flight = flights.get(flight_code);
                        System.out.println(flight.toString());

                        break;

                    case "S":  //S
                        flight_code = command_args[1];
                        classe = command_args[2];
                        number_seats = Integer.parseInt(command_args[3]);
                        
                        flight = flights.get(flight_code);

                        if (checkAvailability(flights, flight, classe, number_seats)) {
                            flight.reserveSeats(classe, number_seats);
                        }

                        break;

                    case "C":  //C
                        //lógica de cancelamento da reserva
                        //função para cancelar reservas
                        reservation_code = Integer.parseInt(command_args[1]);

                        // somehow we get a flight | TODO: Vasco

                        // if (flight.cancelReservation(reservation_code)) {
                        //     System.out.println("Reservation cancelled successfully!");
                        // }
                        // else {
                        //     System.out.println("Something went wrong...");
                        // }
                        break;

                    case "Q":  //Q
                        sc.close();
                        System.out.println("Exiting program...");
                        System.exit(0);
                        break;

                    // default:    // case -1
                    //     System.out.println("Invalid command!");
                }
            }
            //catch (IndexOutOfBoundsException e) {
            catch (ArrayIndexOutOfBoundsException e) {
                System.out.println("gotcha here");
                e.printStackTrace();
                System.out.println("Invalid command!");
            }
        }
    }

    public static Flight readFile(String filename) {
        Flight flight = null;

        String flight_code;
        int colExec, rowExec, colTur, rowTur;

        File file = new File(filename);
        try {

            Scanner file_sc = new Scanner(file);

            String line = file_sc.nextLine();
            if (line.matches(":[A-Z]{2}[0-9]{4}:[1-9]+x[1-9]+")) {  // :AB1234:1x2
                String[] data = line.split(":");
                flight_code = data[0];
                rowExec = Integer.parseInt(data[1].split("x")[0]);
                colExec = Integer.parseInt(data[1].split("x")[1]);
                rowTur = Integer.parseInt(data[2].split("x")[0]);
                colTur = Integer.parseInt(data[2].split("x")[1]);

                flight = new Flight(flight_code, new Airplane(colExec, rowExec, colTur, rowTur));
            }

            else if (line.matches(":[A-Z]{2}[0-9]{4}:[1-9]+x[1-9]+:[1-9]+x[1-9]+")) {   // :AB1234:1x2:3x4
                String[] data = line.replaceFirst(":", "").split(":");  // removes first ":" then splits
                flight_code = data[0];

                // teste
                // System.out.println("Teste 1");
                // for (String coisa : data) {
                //     System.out.println(coisa);
                // }

                // System.out.println("Teste 2");
                // for (String coisa : data[2].split("x")) {
                //     System.out.println(coisa);
                // }


                rowTur = Integer.parseInt(data[1].split("x")[0]);
                colTur = Integer.parseInt(data[1].split("x")[1]);
                rowExec = 0;
                colExec = 0;

                flight = new Flight(flight_code, new Airplane(colTur, rowTur));
            }

            else {
                System.out.println("Invalid file!");
                file_sc.close();
                return null;
            }

            // prints flight information (code and available seats)
            System.out.printf("Código de voo: %s\n", flight_code);
            System.out.println("Lugares disponíveis:");
            if (rowExec*colExec != 0) {
                System.out.printf("%d lugares em classe Executiva;\n", rowExec*colExec);
            }
            System.out.printf("%d lugares em classe Turística;\n", rowTur*colTur);

            // deal with reservations
            while (file_sc.hasNextLine()) {
                String nextLine = file_sc.nextLine();
                if (nextLine.matches("E [1-9]+") || nextLine.matches("T [1-9]+")) {
                    String[] data = nextLine.split(" ");
                    String classe = data[0];
                    int number_seats = Integer.parseInt(data[1]);
                    int num_avail_seats;

                    switch (classe) {
                        case "E":
                            num_avail_seats = flight.getExecSeats();
                            if (num_avail_seats >= number_seats) {
                                //flight.setExecSeats(num_avail_seats - number_seats);
                                flight.reserveSeats(classe, number_seats);
                            }
                            else {
                                System.out.printf("Não foi possível obter lugares para a reserva: %s\n", nextLine);
                            }
                            break;

                        case "T":
                            num_avail_seats = flight.getTurSeats();
                            if (num_avail_seats >= number_seats) {
                                //flight.setTurSeats(num_avail_seats - number_seats);
                                flight.reserveSeats(classe, number_seats);
                            }
                            else {
                                System.out.printf("Não foi possível obter lugares para a reserva: %s\n", nextLine);
                            }
                            break;
                    }
                }
                else {
                    System.out.printf("Invalid file line! -> %s\n", nextLine);
                    file_sc.close();
                    return null;
                }
            }
            file_sc.close();

            return flight;

        }
        catch (FileNotFoundException e) {
            System.out.println("File not found!");
        }
        return flight;
    }

    public static boolean checkAvailability(HashMap<String, Flight> flights, Flight flight, String classe, int number_seats) {
        int num_avail_seats;
        
        switch (classe) {
            case "E":
                num_avail_seats = flight.getExecSeats();
                
                if (num_avail_seats >= number_seats) {
                    return true;
                }
                break;

            case "T":
                num_avail_seats = flight.getTurSeats();

                if (num_avail_seats >= number_seats) {
                    return true;
                }
                
                break;

            default:
                System.out.println("Invalid class!");
                break;
        }

        return false;
    }
}
