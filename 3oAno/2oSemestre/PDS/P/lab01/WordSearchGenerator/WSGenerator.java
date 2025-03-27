package WordSearchGenerator;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Random;
import java.util.Scanner;
import java.io.FileWriter;

// executar no lab01:
// javac WordSearchGenerator/*.java
// java WordSearchGenerator.WSGenerator wl01.txt

public class WSGenerator {
	private static final Random PRNG = new Random();
	
	public static void main(String[] args) {
		// codigo para teste sem o terminal ou debug rapido
		if (args.length == 0) {
			args = new String[1];
			args[0] = "wl01.txt";
		}
		
		args[0] = "WordSearchGenerator/" + args[0];		// modifiquei por causa do javac e dos packages... causava problemas
		ArrayList<String> dados = readFile(args[0]);
	
		char[][] puzzle = generatePuzzle(dados);

		for (int i = 0; i < 15; i++) {
			System.out.println(Arrays.toString(puzzle[i]));
		}

		String outputFname = args[0].replace(".txt", "_result.txt");
		outputPuzzle(puzzle, dados, outputFname);
	}


	public static ArrayList<String> readFile(String filename) {
		ArrayList<String> chaves = new ArrayList<String>();

		try {
			File file = new File(filename);
			Scanner sc = new Scanner(file);

			while (sc.hasNextLine()) {
				String line = sc.nextLine();

				String[] k = line.split(",|;|\\s");
				for (int i = 0; i < k.length; i++) {
					chaves.add(k[i]);
				}
			}
			sc.close();

		} catch (FileNotFoundException e) {
			System.out.println("An error occurred.");
			e.printStackTrace();
		}
		return chaves;
	}


	public static char[][] generatePuzzle(ArrayList<String> words) {
		char[][] puzzle = new char[15][15];
		
		for (int word_i = 0; word_i < words.size(); word_i++) {
			String word = words.get(word_i);
			int x = 0, y = 0;				// default
			Directions d = Directions.Up; 	// default

			boolean valid = false;
			while (!valid) {
				int[] position = randomPosition();
				x = position[0];
				y = position[1];
				d = randomDirection();

				valid = validateDirection(x, y, d, word);

				if (valid) {
					valid = validatePosition(puzzle, x, y, word, d);
				}
			}
			puzzle = insertWord(puzzle, x, y, word, d);
		}
		puzzle = fillEmpty(puzzle);
		return puzzle;
	}


	public static int[] randomPosition() {
		int x = PRNG.nextInt(15);
		int y = PRNG.nextInt(15);
		return new int[] {x, y};
	}


    public static Directions randomDirection()  {
		Directions[] directions = Directions.values();
        return directions[PRNG.nextInt(directions.length)];
    }


	public static boolean validateDirection(int x, int y, Directions direction, String word) {
		int len = word.length() - 1;
		switch (direction) {
			case Up: 		return y - len >= 0;
			case Down:		return y + len < 15;
			case Left: 		return x - len >= 0;
			case Right: 	return x + len < 15;
			case UpLeft: 	return x - len >= 0 && y - len >= 0;
			case UpRight: 	return x - len >= 0 && y + len < 15;
			case DownLeft: 	return x + len < 15 && y - len >= 0;
			case DownRight: return x + len < 15 && y + len < 15;
			default: 		return false;
		}
	}


	public static char[][] insertWord(char[][] puzzle, int x, int y, String word, Directions direction) {
		for (char c : word.toCharArray()) {
			puzzle[x][y] = Character.toLowerCase(c);

			x += direction.getX();
			y += direction.getY();
		}
		return puzzle;
	}


	public static boolean validatePosition(char[][] puzzle, int x, int y, String word, Directions direction) {
		for (char c : word.toCharArray()) {
			if (x < 0 || x >= 15 || y < 0 || y >= 15) return false;

			if (puzzle[x][y] != 0 && puzzle[x][y] != c) return false;

			x += direction.getX();
			y += direction.getY();
		}
		return true;
	}


	public static char[][] fillEmpty(char[][] puzzle) {
		for (int i = 0; i < 15; i++) {
			for (int j = 0; j < 15; j++) {
				if (puzzle[i][j] == 0) {
					puzzle[i][j] = (char) (PRNG.nextInt(26) + 'a');
				}
			}
		}
		return puzzle;
	}

	
	public static void outputPuzzle(char[][] puzzle, ArrayList<String> chaves, String fname) {
		try {
			FileWriter writer = new FileWriter(fname);
			for (int i = 0; i < 15; i++) {
				for (int j = 0; j < 15; j++) {
					writer.write(puzzle[i][j]);
				}
				writer.write("\n");
			}
			for (int i = 0; i < chaves.size(); i++) {
				writer.write(chaves.get(i));
				if (i < chaves.size() - 1) {
					writer.write("\n");
				}
			}

			writer.close();
		} catch (Exception e) {
			System.out.println("An error occurred.");
			e.printStackTrace();
		}
	}
}
