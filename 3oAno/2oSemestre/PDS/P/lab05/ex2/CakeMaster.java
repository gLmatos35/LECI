package ex2;

public class CakeMaster {

    private CakeBuilder cb;
    public void setCakeBuilder(CakeBuilder builder) {
        cb = builder;
    }
    
    public void createCake(String message) {
        cb.createCake();
        cb.setCakeShape(Shape.Circular);
        cb.getCake().setNumCakeLayers(1);
        cb.addMessage(message);
    }
    public void createCake(Shape shape, int layers, String message) {
        cb.createCake();
        cb.setCakeShape(shape);
        cb.getCake().setNumCakeLayers(layers);
        cb.addMessage(message);
    }

    public void createCake(int layers, String message) {
        cb.createCake();
        cb.setCakeShape(Shape.Circular);
        cb.getCake().setNumCakeLayers(layers);
        cb.addMessage(message);
    }

    public Cake getCake() {
        return cb.getCake();
    }


}
