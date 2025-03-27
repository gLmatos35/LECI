import java.io.File;

public class Lugares {
    private int filas;
    private boolean reservado;
    private int lugares_fila;
    private String classe;

    public Lugares(int filas, boolean reservado, int lugares_fila, String classe) {
        this.filas = filas;
        this.lugares_fila = lugares_fila;
        this.classe = classe;
        this.reservado = false;
    }

    public Lugares GetLugares(File file){   

        //TODO

        Lugares places = new Lugares(0, true, 0, "");
        return places;
    }

    
}
