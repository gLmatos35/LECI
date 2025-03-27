package guiao01.ex2;

import java.util.Random;

public enum Position {
    // Coordenadas com base num array bi-dimensional e não num referencial XY
    DOWN(1, 0),
    UP(-1, 0),
    LEFT(0, -1),
    RIGHT(0, 1),
    DOWNLEFT(1, -1),
    DOWNRIGHT(1, 1),
    UPLEFT(-1, -1),
    UPRIGHT(-1, 1);

    final int x, y;

    private Position(int x, int y) {
        this.x = x;
        this.y = y;
    }

    private static final Random random = new Random();

    // Retorna uma posição aleatória
    public static Position randomPosition()  {
        Position[] positions = values();
        return positions[random.nextInt(positions.length)];
    }
}
