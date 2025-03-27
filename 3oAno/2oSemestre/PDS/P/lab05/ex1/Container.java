package ex1;

public abstract class Container {
	protected Portion portion;

    public void setPortion(Portion portion) { 
        this.portion = portion; 
    }

	public static Container create(Portion portion) {
		Container container;
		
		if (portion.getState() == State.Liquid && portion.getTemperature() == Temperature.COLD) {
			container = new PlasticBottle();
		} else if (portion.getState() == State.Liquid && portion.getTemperature() == Temperature.WARM) {
			container = new TermicBottle();
		} else if (portion.getState() == State.Solid && portion.getTemperature() == Temperature.COLD) {
			container = new PlasticBag();
		} else if (portion.getState() == State.Solid && portion.getTemperature() == Temperature.WARM) {
			container = new Tupperware();
		} else {
			throw new IllegalArgumentException("Unknown portion type!");
		}
	
		container.setPortion(portion);
		return container;
	}
}

class PlasticBottle extends Container {
	public String toString() { return "PlasticBottle with portion = " + portion; }
}

class TermicBottle extends Container {
	public String toString() { return "TermicBottle with portion = " + portion; }
}

class Tupperware extends Container {
	public String toString() { return "Tupperware with portion = " + portion; }
}

class PlasticBag extends Container {
	public String toString() { return "PlasticBag with portion = " + portion; }
}