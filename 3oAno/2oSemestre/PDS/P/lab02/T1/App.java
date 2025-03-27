import java.util.Scanner;
import java.io.File;
import java.util.ArrayList;

public class App {
    public static void main(String[] args) throws Exception {
        /*
                * 1.O puzzle é sempre quadrado, com o tamanhoexatode15x15.
                * 2.As letras do puzzle estão emminúsculas.
                * 3.Na lista, as palavrastem a primeira letra em maiúsculas.
                * 4.O caracter # sinaliza um comentário.
                * 5.As palavras são compostas por caracteres alfabéticos.
                * 6.No puzzle e na lista de palavras, oficheiro nãopodeconterlinhasvazias.
                * 7.Cada linha pode termais do que uma palavra, separadas por vírgula, espaço ouponto e vírgula.
                * 8.As palavras têm de ter pelo menos 3 caracteres.
                * 9.Todas as palavras da lista têm de estar no puzzle e apenas uma vez.
        * 10.A lista de palavras pode conter palavrascom partes iguais(por exemplo, podeconterFAROeFAROL).Nestes casosdeve ser considerado apenas a maior(FAROL)
        */

        //Scanner sc = new Scanner(System.in);

        //File file = new File("WordSearch1.txt");

        Scanner file = new Scanner(new File("sopaDeLetras.txt"));
        char[][] caracteres = new char[15][15];
        ArrayList<String> palavras = new ArrayList<String>();

        int counter = 0;
        // Tratamento dos caracteres da sopa
        while (file.hasNextLine() && counter<15) {
            String line = file.nextLine();
            
            // Verificar se a linha é vazia
            if (line.length() == 0) {
                System.out.print("Linha vazia!");
                System.exit(0);
            }

            // Separação de possíveis comentários
            line = line.split("#")[0];
            line = line.trim();

            // Verificar se todos os caracteres são alfabéticos, minúsculos e o comprimento é de 15 caracteres
            if (!line.matches("[a-z]{15}")) {
                System.out.print("Caracter inválido detetado!");
                System.exit(0);
            }

            // Adição dos caracteres ao array bi-dimensional
            for (int c=0; c<15; c++) {
                caracteres[counter][c] = line.charAt(c);
            }

            counter++;
            //System.out.println(line);   // Teste
        }

        // Tratamento das palavras da sopa
        while (file.hasNextLine()) {
            String line = file.nextLine();
            String[] words = line.split("[,;\s]");

            for (int i=0; i<words.length; i++) {
                // Verificar que a primeira letra é maiúscula
                if (!Character.isUpperCase(words[i].charAt(0))) {
                    System.out.print("A primeira letra da palavra não é maiúscula!");
                    System.exit(0);
                }

                // Verificar se o tamanho é igual ou maior a 3
                if (words[i].length() < 3) {
                    System.out.print("A palavra tem de ter pelo menos 3 caracteres!");
                    System.exit(0);
                }

                // Adicionar ao ArrayList se a palavra não estiver lá
                if (!palavras.contains(words[i])) {
                    palavras.add(words[i].toLowerCase());

                    //System.out.println(words[i]); // Teste
                }
            }
        }

        file.close();

        ArrayList<String> maioresPalavras = new ArrayList<String>();
        boolean flag;

        ///validar apenas palavras maiores///
        for(int i = 0;i<palavras.size();i++){
            flag = true;
            for(int j = 0;j<palavras.size();j++){
                if(i == j){
                    continue;
                }else if(palavras.get(i).equals(palavras.get(j))){
                    flag = false;
                }else{
                    if(palavras.get(j).contains(palavras.get(i))){
                        flag = false;
                    }
                }
            }

            if(flag){
                maioresPalavras.add(palavras.get(i));
            }
        }

        // Criação do objeto sopa
        Sopa sopa = new Sopa(caracteres, maioresPalavras);
        WSSolver solver = new WSSolver();

        char[][] result = solver.findWords(sopa);
        System.out.print(sopa.toString());
        for(int i = 0;i<15;i++){
            for(int j = 0;j<15;j++){
                System.out.print(result[i][j] + " ");
            }
            System.out.println();
        }
    }
}
