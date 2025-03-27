package guiao01.ex2;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class ex2 {
    public static void main(String[] args) {
        // Validação de argumentos
        String filename = "src/guiao01/ex2/wordlist1.txt";
        String soupname = "";

        /*
        int nargs = args.length;
        switch (nargs) {
            case 2:
                if (args[0] != "-w") {
                    System.err.printf("%s desconhecido.\nEsperado: -w\n", args[0]);
                }
                filename = args[1];
                break;

            case 4:
                if (args[0] != "-w") {
                    System.err.printf("%s desconhecido.\nEsperado: -w\n", args[0]);
                }
                if (args[2] != "-w") {
                    System.err.printf("%s desconhecido.\nEsperado: -s\n", args[2]);
                }
                filename = args[1];
                soupname = args[3];
                break;

            default:
                System.err.println("Número de argumentos incorretos!");
        }
        */

        // Input do nome do ficheiro e do nome da sopa
        /*
        Scanner sc = new Scanner(System.in);

        System.out.print("Nome do ficheiro: ");
        filename = sc.next();

        System.out.print("Nome da sopa: ");
        soupname = sc.next();

        sc.close();
        */

        // Leitura do ficheiro
        try {
            File file = new File(filename);

            ArrayList<String> palavras = new ArrayList<>();

            Scanner file_sc = new Scanner(file);

            while (file_sc.hasNextLine()) {
                palavras.add(file_sc.nextLine());
            }

            file_sc.close();

            // Geração da sopa de letras
            WSGenerator wsgen = new WSGenerator(palavras);

            // Print da sopa de letras
            System.out.println(wsgen.toString());

        } catch (FileNotFoundException e) {
            System.err.printf("Error opening %s.\n", filename);
            System.exit(0);
        }
    }
}
