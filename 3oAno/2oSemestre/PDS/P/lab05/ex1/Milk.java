package ex1;

public class Milk implements Portion {
	public State getState() { return State.Liquid; }
	public Temperature getTemperature() { return Temperature.WARM; }

	public String toString() {
		return "Milk: Temperature " + getTemperature() + ", State " + getState();
	}
}
