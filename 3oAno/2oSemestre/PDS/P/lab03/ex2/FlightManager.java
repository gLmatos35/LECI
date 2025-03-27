package ex2;

import java.util.ArrayList;

public class FlightManager {
	private ArrayList<Booking> bookings;
	private Flight flight;

	public FlightManager(Flight flight) {
		this.flight = flight;
		this.bookings = new ArrayList<Booking>();
	}

	public ArrayList<Booking> getBookings() {
		return this.bookings;
	}


	public void addBooking(Classe classe, int numReservas) {
		if (classe == null) {
			System.out.println("Classe invalida.");
			return;
		} else if (numReservas <= 0) {
			System.out.println("Numero de reservas invalido.");
			return;
		}

		Booking booking = new Booking(classe, numReservas, this.flight);
		bookings.add(booking);
	}

	public ArrayList<Booking> getBookings(Classe classe) {
		return bookings;
	}

	public Booking getLastBooking() {
		return bookings.get(bookings.size() - 1);
	}

	public void cancelBooking(int numReserva) {
		// System.out.println("here");

		Plane plane = flight.getPlane();
		for (Booking booking : bookings) {
			// System.out.println("here2");

			if (booking.getNumReserva() == numReserva) {
				// System.out.println("here3");

				bookings.remove(booking);

				ArrayList<Seat> seats = booking.getSeats();

				for (Seat seat : seats) {
					plane.freeSeat(seat);
				}
				break;
			}
		}
	}

	public void displaySeats() {
		flight.getPlane().displaySeats();
	}
}
