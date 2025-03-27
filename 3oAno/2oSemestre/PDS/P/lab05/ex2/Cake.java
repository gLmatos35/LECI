package ex2;

public class Cake {  
    private Shape shape;  
    private String cakeLayer;  
    private int numCakeLayers;  
    private Cream midLayerCream;  
    private Cream topLayerCream;  
    private Topping topping;  
    private String message;  

    // Constructor  

    // Getters and Setters  

    public Shape getShape() {
        return this.shape;
    }


    public String getCakeLayer() {
        return this.cakeLayer;
    }


    public int getNumCakeLayers() {
        return this.numCakeLayers;
    }


    public Cream getMidLayerCream() {
        return this.midLayerCream;
    }


    public Cream getTopLayerCream() {
        return this.topLayerCream;
    }


    public Topping getTopping() {
        return this.topping;
    }

    public void setMessage(String message) {
        this.message = message;
    }


    public void setShape(Shape shape) {  
        this.shape = shape;  
    }  



    public void setCakeLayer(String cakeLayer) {  
        this.cakeLayer = cakeLayer;  
    }  



    public void setNumCakeLayers(int numCakeLayers) {  
        this.numCakeLayers = numCakeLayers;  
    }  



    public void setMidLayerCream(Cream midLayerCream) {  
        this.midLayerCream = midLayerCream;  
    }  



    public void setTopLayerCream(Cream topLayerCream) {  
        this.topLayerCream = topLayerCream;  
    }  



    public void setTopping(Topping topping) {  
        this.topping = topping;  
    }  

    @Override
    public String toString() {  

        if(this.getNumCakeLayers() > 1) {
            return getCakeLayer() + " cake with " + getNumCakeLayers() + " layers and " + this.getMidLayerCream().toString() + 
            " cream, topped with " + this.topLayerCream.toString() + " cream and " + this.getTopping().toString() + 
                ". Message says: \"" + this.message + "\".";  
        } else {
            return getCakeLayer() + " cake with " + getNumCakeLayers() + " layers, topped with " + 
                this.topLayerCream.toString() + " cream and " + this.getTopping().toString() + 
                ". Message says: \"" + this.message + "\".";  
        }
    }
    


    // Other methods can be added here  
}  
