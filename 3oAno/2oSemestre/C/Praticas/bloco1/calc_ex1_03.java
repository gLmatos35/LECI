import java.util.Stack;
import java.util.Scanner;
import java.util.ArrayList;

public class calc_ex1_03 {
    public static void main(String[] args) {

	}

	public static ArrayList<String> readInput() {
		Scanner sc = new Scanner(System.in);
		System.out.print(">> ");
		String input = sc.nextLine();

		ArrayList<String> inputString = new ArrayList<>();

		for (String part : input.split(" ")) {
			inputString.add(part);
		}

		sc.close();

		return inputString;
	}

	public static boolean verifyInput(ArrayList<String> input) {
		if (input.size() != 3) {
			System.err.println("Entrada inválida");
			return false;
		}

		return true;
	}
}
