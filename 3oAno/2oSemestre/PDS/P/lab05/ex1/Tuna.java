package ex1;

public class Tuna implements Portion {
	public State getState() { return State.Solid; }
	public Temperature getTemperature() { return Temperature.COLD; }

	public String toString() {
		return "Tuna: Temperature " + getTemperature() + ", State " + getState();
	}
}
