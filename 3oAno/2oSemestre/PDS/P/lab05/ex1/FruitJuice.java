package ex1;

public class FruitJuice implements Portion {
	private String fruitName;
    
    public FruitJuice(String fruitName) {
        this.fruitName = fruitName;
    }

	public FruitJuice() {
		this.fruitName = "Orange";
	}

	public State getState() { return State.Liquid; }
	public Temperature getTemperature() { return Temperature.COLD; }
	public String getFruitName() { return fruitName; }

	public String toString() {
		return "FruitJuice: " + getFruitName() + ", Temperature " + getTemperature() + ", State " + getState();
	}
}
