package ex2;

public class Flight {
	private String flightCode;
	private Plane plane;
	private int nextReserva;

	public Flight(String flightCode, Plane plane) {
		this.flightCode = flightCode;
		this.plane = plane;
		this.nextReserva = 0;
	}

// getters e setters //
	public String getFlightCode() {
		return this.flightCode;
	}

	public void setFlightCode(String flightCode) {
		this.flightCode = flightCode;
	}

	public Plane getPlane() {
		return this.plane;
	}

	public void setPlane(Plane plane) {
		this.plane = plane;
	}

	public int getNextReserva() {
		return ++this.nextReserva;
	}


	public void displaySeats() {
		plane.displaySeats();
	}
//

	@Override
	public String toString() {
		return 	"Flight Code: " + getFlightCode() +
				"\nPlane: " + getPlane();
	}
}
