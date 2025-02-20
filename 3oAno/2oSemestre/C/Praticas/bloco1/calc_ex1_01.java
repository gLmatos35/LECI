import java.util.Scanner;

public class calc_ex1_01 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);

		System.out.print(">> ");

		String input = sc.nextLine();

		String[] parts = input.split(" ");

		int a = Integer.parseInt(parts[0]);
		int b = Integer.parseInt(parts[2]);
		String operator = parts[1];

		if (operator.equals("+")) {
			System.out.println(a + b);
		} else if (operator.equals("-")) {
			System.out.println(a - b);
		} else if (operator.equals("*")) {
			System.out.println(a * b);
		} else if (operator.equals("/")) {
			System.out.println(a / b);
		} else {
			System.err.println("Operador inválido");
		}

		sc.close();
		return;
	}
}