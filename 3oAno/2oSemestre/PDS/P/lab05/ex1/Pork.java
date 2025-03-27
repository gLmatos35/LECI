package ex1;

public class Pork implements Portion {
	public State getState() { return State.Solid; }
	public Temperature getTemperature() { return Temperature.WARM; }

	public String toString() {
		return "Pork: Temperature " + getTemperature() + ", State " + getState();
	}
}
