package ex2;

public class YogurtCakeBuilder extends CakeBuilder {

    @Override
    public void setCakeShape(Shape shape) {cake.setShape(shape);}


    @Override
    public void addCakeLayer() {cake.setCakeLayer("Yogurt");}

    @Override
    public void addCreamLayer() { cake.setMidLayerCream(Cream.Vanilla);}

    @Override
    public void addTopLayer() {cake.setTopLayerCream(Cream.Red_Berries);}

    @Override
    public void addTopping() {cake.setTopping(Topping.Chocolate);}
    @Override
    public void addMessage(String m) {
        cake.setMessage(m);
    }

    @Override
    public void createCake() {
        addCakeLayer();
        addTopping();
        addTopLayer();
        addCreamLayer();
    }
    
}