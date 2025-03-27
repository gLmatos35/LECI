package ex1;

public class PortionFactory {
	public static Portion create(String state, Temperature temperature) {
		if (state == "Beverage" && temperature == Temperature.WARM) {
			return new Milk();
		} 
		if (state == "Beverage" && temperature == Temperature.COLD) {
			return new FruitJuice();
		} 
		if (state == "Meat" && temperature == Temperature.COLD) {
			return new Tuna();
		} 
		if (state == "Meat" && temperature == Temperature.WARM) {
			return new Pork();
		} 
		else {
			throw new IllegalArgumentException("argumentos invalidos idk");
		}
	}

	public static Portion create(String state, Temperature temperature, String other) {
		if (state == "Beverage" && temperature == Temperature.WARM) {
			return new Milk();
		} 
		if (state == "Beverage" && temperature == Temperature.COLD) {
			return new FruitJuice(other);
		} 
		if (state == "Meat" && temperature == Temperature.COLD) {
			return new Tuna();
		} 
		if (state == "Meat" && temperature == Temperature.WARM) {
			return new Pork();
		} 
		else {
			throw new IllegalArgumentException("argumentos invalidos idk");
		}
	}
}
