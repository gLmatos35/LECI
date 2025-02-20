import java.util.Scanner;
import java.util.HashMap;

public class calc_ex1_02 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        HashMap<String, Integer> variables = new HashMap<>();

        System.out.println("Type 'exit' to end the program");

        boolean start = true;
        while (start) {
            System.out.print(">> ");

            String input = sc.nextLine().trim();

            if (input.equals("exit")) {
                start = false;
                break;
            }

            String[] parts = input.split(" ");

            if (parts.length == 3 && parts[1].equals("=") && parts[0].matches("[a-zA-Z]")) {
                variables.put(parts[0], Integer.parseInt(parts[2]));
                System.out.println(parts[0] + " = " + parts[2]);
                continue;
            }

            if (parts.length == 5 && parts[1].equals("=")) {
                String var = parts[0];
                int a = getValue(parts[2], variables);
                int b = getValue(parts[4], variables);
                int result = 0;

                switch (parts[3]) {
                    case "+":
                        result = a + b;
                        break;
                    case "-":
                        result = a - b;
                        break;
                    case "*":
                        result = a * b;
                        break;
                    case "/":
                        if (b != 0) {
                            result = a / b;
                        } else {
                            System.err.println("trollada, divisao por 0");
                            continue;
                        }
                        break;
                    default:
                        System.err.println("Operador invalido");
                        continue;
                }

                variables.put(var, result);
                System.out.println(var + " = " + result);
                continue;
            }

            if (parts.length == 3) {
                int a = getValue(parts[0], variables);
                int b = getValue(parts[2], variables);
                String operator = parts[1];

                switch (operator) {
                    case "+":
                        System.out.println("Result = " + (a + b));
                        break;
                    case "-":
                        System.out.println("Result = " + (a - b));
                        break;
                    case "*":
                        System.out.println("Result = " + (a * b));
                        break;
                    case "/":
                        if (b != 0) {
                            System.out.println("Result = " + (a / b));
                        } else {
                            System.err.println("Erro: divisão por zero");
                        }
                        break;
                    default:
                        System.err.println("Operador invalido");
                }
                continue;
            }

            System.err.println("trollada insana");
        }

        sc.close();
    }

    private static int getValue(String str, HashMap<String, Integer> variables) {
        if (variables.containsKey(str)) {
            return variables.get(str);
        }
        try {
            return Integer.parseInt(str);
        } catch (NumberFormatException e) {
            System.err.println("Variável nao definida: " + str);
            return 0;
        }
    }
}
