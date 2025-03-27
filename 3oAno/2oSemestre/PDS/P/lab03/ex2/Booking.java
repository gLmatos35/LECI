package ex2;

import java.util.ArrayList;

public class Booking {
	private static int nextReserva = 0;
	private int numReserva;
	private Classe classe;
	private int numReservas;
	private Plane plane;
	private ArrayList<Seat> seats;

	private String reservationCode;

	public Booking(Classe classe, int numReservas, Flight flight) {
		this.classe = classe;
		this.numReservas = numReservas;
		this.plane = flight.getPlane();
		String flightCode = flight.getFlightCode();

		if (plane.validateBooking(classe, numReservas)) {
			this.numReserva = ++nextReserva;
			this.seats = chooseSeats();
		}
		this.reservationCode = flightCode + ":" + numReserva;
	}

	public Classe getClasse() {
		return this.classe;
	}

	public int getNumBookings() {
		return this.numReservas;
	}

	public int getNumReserva() {
		return this.numReserva;
	}

	public ArrayList<Seat> getSeats() {
		return this.seats;
	}

	public String getReservationCode() {
		return this.reservationCode;
	}


	public ArrayList<Seat> chooseSeats() {
		ArrayList<Seat> seats = new ArrayList<Seat>();

		Classe c = this.getClasse();
		int nReservas = this.getNumBookings();

		int seatRow = 1;
		int execRows = plane.getExecRows();

		switch(c) {
			case E:
				if (!(plane.validateBooking(c, nReservas))) {
					break;
				}

				// allocateSeats(seatRow, execRows, seats, nReservas);

				if (getFirstFreeRow(seatRow, execRows) != -1) {
					int freeSeatRow = getFirstFreeRow(seatRow, execRows);
					allocateSeats(freeSeatRow, execRows, seats, nReservas);
				} else {
					allocateSeats(seatRow, execRows, seats, nReservas);
				}

				break;
			case T:
				int turRows = plane.getTurRows();

				seatRow += execRows;

				if (!(plane.validateBooking(c, nReservas))) {
					break;
				}

				// allocateSeats(seatRow, (turRows + execRows), seats, nReservas);

				if (getFirstFreeRow(seatRow, (turRows + execRows)) != -1) {
					int freeSeatRow = getFirstFreeRow(seatRow, (turRows + execRows));
					allocateSeats(freeSeatRow, (turRows + execRows), seats, nReservas);
				} else {
					allocateSeats(seatRow, (turRows + execRows), seats, nReservas);
				}

				break;
			default:
				System.out.println("classe trolladinha");
				break;
		}
		return seats;
	}
	
	private void allocateSeats(int startRow, int endRow, ArrayList<Seat> seats, int nReservas) {
		ArrayList<ArrayList<Integer>> pConfig = plane.getPlaneConfig();
		Classe c = this.getClasse();
		int seatRow = startRow - 1;
		for (int i = seatRow; i < endRow && seats.size() < nReservas; i++) {
			char seatLetter = 'A';
			for (int j = 0; j < pConfig.get(i).size() && seats.size() < nReservas; j++) {
				if (pConfig.get(i).get(j) == 0) {
					Seat s = new Seat(seatRow + 1, seatLetter, c, numReserva);
					seats.add(s);
					plane.fillSeat(s, numReserva);
				}
				seatLetter++;
			}
			seatRow++;
		}
	}

	private int getFirstFreeRow(int startRow, int endRow) {
		ArrayList<ArrayList<Integer>> pConfig = plane.getPlaneConfig();
		int seatRow = startRow - 1;
		for (int i = seatRow; i < endRow; i++) {
			boolean isRowEmpty = true;
			for (int j = 0; j < pConfig.get(i).size(); j++) {
				if (pConfig.get(i).get(j) != 0) {
					isRowEmpty = false;
					break;
				}
			}
			if (isRowEmpty) {
				return i + 1;
			}
		}
		return -1;
	}

	@Override
	public String toString() {
		String str = "Reserva: " + this.reservationCode + "\n";
		str += "Classe: " + this.classe + "\n";
		str += "Número de reservas: " + this.numReservas + "\n";
		return str;
	}
}
