package ex2;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.HashMap;


public class Main {

	private static HashMap<String, Flight> flightsMap = new HashMap<>();
	private static HashMap<String, FlightManager> managersMap = new HashMap<>();

	public static void main(String[] args) {
		String fCode, configExec, configTur;
		FlightManager manager;
		String fname;

		if (args.length == 1) {
			fname = args[0];
		} else {
			fname = null;
		}

		Scanner sc = new Scanner(System.in);

        while (true) {
			String[] data;
			if (fname == null) {
				System.out.println("\nEscolha uma opção: (H para ajuda)");
				System.out.print(">> ");
				String input = sc.nextLine().trim();
				System.out.println();

				if (input.equalsIgnoreCase("Q")) {
					System.out.println("Exiting...");
					break;
				}

				if (input.equalsIgnoreCase("H")) {
					System.out.println("R filename \n\t- lê um ficheiro de texto contendo informação sobre um voo");
					System.out.println("P flightcode\n\t- exibe o plano das reservas de um voo");
					System.out.println("S flight_code class number_seats\n\t- acrescenta uma nova reserva a um voo");
					System.out.println("C reservation_code\n\t- cancela uma reserva\n");
					System.out.println("Q\n\t- termina o programa\n");
					continue;
				}

				if (!validInput(input)) {
					System.out.println("Input inválido");
					continue;
				}

				data = input.split("\\s+");
			} else {
				String input = "R " + fname;
				data = input.split("\\s+");
				System.out.println();
			}
			switch(data[0].toUpperCase()) {
				case "R":
					// String fname = "lab03/ex2/" + data[1];

					// provavelmente há uma maneira melhor de fazer isto
					String[] possiblePaths = {
						data[1],
						"ex2/" + data[1],
						"lab03/ex2/" + data[1]
					};
			
					for (String path : possiblePaths) {
						File file = new File(path);
						if (file.exists()) {
							fname = file.getPath();
							break;
						} else {
							fname = null;
						}
					}

					if (fname == null) {
						System.out.println("O ficheiro fornecido, " + "'" + data[1] + "'" + ", não existe");
						continue;
					}
					//

					// fdata[0] -> flight info	[0] -> flight code	[1] -> configExec	[2] -> configTur
					// fdata[1] -> bookings		[0] -> booking1		[1] -> booking2		...
					ArrayList<ArrayList<String>> fdata = readFile(fname);

					if ((fdata.get(0).size() != 2) && (fdata.get(0).size() != 3)) {
						System.out.println("Configuração do avião no ficheiro inválida.");
						continue;
					}

					// pode ou não haver lugares executivos
					if ((fdata.get(0).size() == 2)) {
						fCode = fdata.get(0).get(0);
						configExec = null;
						configTur = fdata.get(0).get(1);
					} else {
						fCode = fdata.get(0).get(0);
						configExec = fdata.get(0).get(1);
						configTur = fdata.get(0).get(2);
					}

					Plane plane = new Plane(configExec, configTur);
					Flight flight = new Flight(fCode, plane);

					if (flightsMap.containsKey(fCode)) {
						System.out.println("O voo com código '" + fCode + "' já existe.");
						break;
					}
					flightsMap.put(fCode, flight);

					if (configExec != null) {
						System.out.println("Código de voo " + fCode + ". Lugares disponíveis: " + plane.getFreeExecSeats() + " lugares em classe Executiva; " + plane.getFreeTurSeats() + " lugares em classe Turística.");
					} else {
						System.out.println("Código de voo " + fCode + ". Lugares disponíveis: " + plane.getFreeTurSeats() + " lugares em classe Turística.");
						System.out.println("Classe executiva não disponível neste voo.");
					}

					manager = new FlightManager(flight);
					managersMap.put(fCode, manager);

					ArrayList<String> bookings = fdata.get(1);
					for (String booking : bookings) {
						String[] bData = booking.split("\\s+");
						Classe c = bData[0].equalsIgnoreCase("E") ? Classe.E : bData[0].equalsIgnoreCase("T") ? Classe.T : null;
						int nReservas = Integer.parseInt(bData[1]);
						manager.addBooking(c, nReservas);
					}

					fname = null;

					break;
				case "P":
					fCode = data[1];
					if (flightsMap.containsKey(fCode)) {
						Flight f = flightsMap.get(fCode);
						f.getPlane().displaySeats();
					} else {
						System.out.println("O voo com código '" + fCode + "' não existe.");
					}

					break;
				case "S":
					fCode = data[1];
					Classe c = data[2].equalsIgnoreCase("E") ? Classe.E : data[2].equalsIgnoreCase("T") ? Classe.T : null;

					try {
						int nReservas = Integer.parseInt(data[3]);

						if (c == null || nReservas <= 0) {
							break;
						}

						if (flightsMap.containsKey(fCode)) {
							Flight f = flightsMap.get(fCode);

							if (!(f.getPlane().validateBooking(c, nReservas))) {
								break;
							}

							manager = managersMap.get(fCode);
							manager.addBooking(c, nReservas);

							int numReserva = manager.getLastBooking().getNumReserva();

							System.out.print(fCode + ":" + numReserva + " = ");
							ArrayList<Seat> seats = manager.getLastBooking().getSeats();
							for (Seat s : seats) {
								System.out.print(s);
								if (seats.indexOf(s) != seats.size() - 1) {
									System.out.print(" | ");
								}
							}
							System.out.println();

						} else {
							System.out.println("O voo com código '" + fCode + "' não existe.");
						}
					} catch (NumberFormatException e) {
						System.out.println("Número de lugares inválido.");
					}

					break;
				case "C":
					String reservationCode = data[1];
					String[] reservaData = reservationCode.split(":");

					if (reservaData.length != 2) {
						System.out.println("Código de reserva inválido.");
						break;
					}

					fCode = reservaData[0];

					try {
						int numReserva = Integer.parseInt(reservaData[1]);

						if (flightsMap.containsKey(fCode)) {
							manager = managersMap.get(fCode);

							manager.cancelBooking(numReserva);

							System.out.println("Reserva " + fCode + ":" + numReserva + " cancelada.");
						} else {
							System.out.println("O voo '" + fCode + "' não existe.");
						}

					} catch (NumberFormatException e) {
						System.out.println("Código de reserva inválido.");
						break;
					}
					
					break;
				default:
					System.out.println("Opção inválida");
					break;
				}
        }
		sc.close();
	}

	public static ArrayList<ArrayList<String>> readFile(String filename) {
		ArrayList<ArrayList<String>> flightData = new ArrayList<ArrayList<String>>();
		ArrayList<String> flightInfo = new ArrayList<String>();
		ArrayList<String> flightBookings = new ArrayList<String>();
		int i;

		try (Scanner sc = new Scanner(new File(filename))) {

			String line = sc.nextLine();

			String[] data = line.split(":");

			// verificar se o ficheiro começa com ":"
			if (!(data[0].isEmpty())) {
				return null;
			}

			for (i = 0; i < data.length; i++) {
				if (!data[i].isEmpty()) {
					flightInfo.add(data[i]);
				}
			}

			while (sc.hasNextLine()) {
				line = sc.nextLine();
				data = line.split("\n");

				for (i = 0; i < data.length; i++) {
					flightBookings.add(data[i]);
				}
			}
			sc.close();

			flightData.add(flightInfo);
			flightData.add(flightBookings);

		} catch (FileNotFoundException e) {
			System.out.println("An error occurred.");
			e.printStackTrace();
		}

		return flightData;
	}


	public static boolean validInput(String input) {
		String[] data = input.split("\\s+");

		if (!data[0].toUpperCase().matches("[RPSC]") || data.length < 2) {
			return false;
		}

		if ((data[0].toUpperCase().matches("[RPC]") && data.length != 2) || (data[0].equalsIgnoreCase("S") && data.length != 4)) {
			return false;
		}

		return true;
	}
}
