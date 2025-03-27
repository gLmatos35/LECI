package ex2;

public class ChocolateCakeBuilder extends CakeBuilder {
    
    @Override
    public void setCakeShape(Shape shape) {cake.setShape(shape);}

    @Override
    public void addCakeLayer() {cake.setCakeLayer("Soft chocolate");}

    @Override
    public void addCreamLayer() {cake.setMidLayerCream(null);}

    @Override
    public void addTopLayer() {cake.setTopLayerCream(Cream.Whipped_Cream);}

    @Override
    public void addTopping() {cake.setTopping(Topping.Fruit);}

    @Override
    public void addMessage(String m) {
        cake.setMessage(m);
    }

    @Override
    public void createCake() {
        addCakeLayer();
        addTopping();
        addTopLayer();
    }

}