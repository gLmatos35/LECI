import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.nio.file.Paths;
import java.util.Scanner;

public class ex4 {
	public static void main(String[] args) {
		HashMap<String,Integer> numbers = readFile("numbers.txt");

		// for(String number : numbers.keySet()) {
		// 	System.out.println(number + ": " + numbers.get(number));
		// }

		Scanner sc = new Scanner(System.in);

		String input = sc.nextLine();
		String[] parts = input.split("\s|-");

		int counter = 0;
		while (counter != parts.length) {
			String key = parts[counter];

			if (!numbers.containsKey(key)) {
				System.out.print(key);
			} else {
				System.out.print(numbers.get(key));
			}
			System.out.print(" ");

			counter++;
		}

		System.out.println("");
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
