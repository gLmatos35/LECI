package guiao01.ex2;

import java.util.ArrayList;
import java.util.Random;

public class WSGenerator {
    ArrayList<String> palavras;
    char[][] caracteres;
    
    public WSGenerator(ArrayList<String> palavras) {
        this.palavras = palavras;
        this.caracteres = formatSoup(palavras);
    }
    
    private char[][] formatSoup(ArrayList<String> palavras) {
        char[][] caracteres = new char[15][15];

        for (int i=0; i<15; i++) {
            for (int j=0; j<15; j++) {
                caracteres[i][j] = '-';
            }
        }

        Random r = new Random();
        //for (String palavra : palavras) {
        int n=0;
        while (n != palavras.size()) {
            int x = r.nextInt(15);
            int y = r.nextInt(15);

            for (int i=0; i<8; i++) {
                Position position = Position.randomPosition();

                if (isValid(palavras.get(n), position, x, y, caracteres)) {
                    int comprimento = palavras.get(n).length();

                    // Substituir os caracteres respetivos
                    for (int j=0; j<comprimento; j++) {
                        caracteres[x][y] = palavras.get(n).charAt(j);
                        x += position.x;
                        y += position.y;
                    }
                    n++;
                    break;
                }
            }
        }
        return caracteres;
    }

    // Verifica se para a posição pretendida, a palavra não sobrepõe nenhuma palavra e se o fizer, que os caracteres coincidem
    private boolean matches(String palavra, Position position, int x, int y, char[][] caracteres) {
        int comprimento = palavra.length();

        // Verifica todos as posições dos caracteres
        for (int i=0; i<comprimento; i++) {
            char caracter = palavra.charAt(i);

            // Se o caracter estiver não vazio ou não for igual, retorna false
            //if (!(caracteres[x][y] == '-' || caracteres[x][y] == caracter)) {
            if (caracteres[x][y] != caracter && caracteres[x][y] != '-') {
                return false;
            }
            x += position.x;
            y += position.y;
        }
        return true;
    }

    // Verifica se para a posição pretendida, a palavra tem espaço
    private boolean hasRoom(String palavra, Position position, int x, int y) {
        int comprimento = palavra.length();

        // Soma N vezes o vetor unitário correspondente à posição
        for (int i=0; i<comprimento; i++) {
            x += position.x;
            y += position.y;
        }

        // Verifica se as novas coordenadas estão fora dos limites
        return (0 <= x & x <= 14 & 0 <= y & y <= 14);
    }

    // Verifica se a palavra tem espaço para ser escrita na posição indicada
    // Verifica que a palavra não sobrepões outras palavras. Se o fizer, os caracteres têm de coincidir
    private boolean isValid(String palavra, Position position, int x, int y, char[][] caracteres) {
        if (hasRoom(palavra, position, x, y)) {
            return matches(palavra, position, x, y, caracteres);
        }
        return false;
    }

    @Override
    public String toString() {
        String result = "";

        for (int i=0; i<15; i++) {
            for (int j=0; j<15; j++) {
                //System.out.print(caracteres[i][j]);
                result += caracteres[i][j] + " ";
            }
            result += "\n";
        }

        return result;
    }
}
