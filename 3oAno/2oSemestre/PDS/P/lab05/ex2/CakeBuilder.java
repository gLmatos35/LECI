package ex2;

abstract class CakeBuilder{
    protected Cake cake = new Cake();
    public Cake getCake() {
        return cake;
    }

    public abstract void setCakeShape(Shape shape);
    public abstract void addCakeLayer();
    public abstract void addCreamLayer();
    public abstract void addTopLayer();
    public abstract void addTopping();
    public abstract void addMessage(String m);
    public abstract void createCake();
}
