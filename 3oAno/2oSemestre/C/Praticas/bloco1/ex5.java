import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Scanner;

// se o numero for maior que o anterior, multiplicar
// se o numero for menor que o anterior, somar
// ex: two thousand three hundrer thirty three -> 2*1000 + 3*100 + 30 + 3

// Resultado   Acumulador   Numero

public class ex5 {
	public static void main(String[] args) {
		HashMap<String,Integer> numbers = readFile("numbers.txt");

		Scanner sc = new Scanner(System.in);

		while(sc.hasNextLine()) {
			Scanner scline = new Scanner(sc.nextLine());
			int res = 0;
			int acum = 0;
			int num = 0;
			String key = "";

			while(scline.hasNext()) {
				try {
					key = scline.next();
				} catch (NumberFormatException e) {
					System.out.println("Input inválido.");
					e.printStackTrace();
				}

				if (!numbers.containsKey(key)) {
					System.out.print(key);
					continue;
				} else {
					// System.out.print(numbers.get(key));
					num = numbers.get(key);
				}

				// if (num == 0) { 
				// 	num = numbers.get(scline.next());
				// 	System.out.println(num);
				// }

				// if (num > acum) {

				// }

				System.out.print(" ");
			}
			System.out.println("");
			scline.close();
		}
		sc.close();
	}

	static HashMap<String, Integer> readFile(String fname) {
		HashMap<String, Integer> n = new HashMap<String, Integer>();

		try {
			File f = new File(fname);
			Scanner reader = new Scanner(f);

			while (reader.hasNextLine()) {
				String data = reader.nextLine();
				data = data.replace("-", " ");
				String[] parts = data.split("\s+");

				n.put(parts[1], Integer.parseInt(parts[0]));
			}

			reader.close();

		} catch (FileNotFoundException e) {
			System.out.println("An error occurred.");
			e.printStackTrace();
		}

		return n;
	}
}
