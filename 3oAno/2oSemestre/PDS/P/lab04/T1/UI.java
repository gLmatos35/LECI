public class UI{

    public void listMenuOptions() {
        String menu = String.format("""
            %-32s - Apresenta as opções do menu.
            %-40s - Lê um ficheiro de texto contento informação sobre um voo.
            %-40s - Exibe o plano das reservas de um voo.
            %-40s - Acrescenta uma nova reserva a um voo, com indicação do código do voo, da classe (T / E), e do número de lugares.
            %-40s - Cancela uma reserva.
            %-32s - Termina o programa.
            """, 
            "H", 
            "R " + "\033[3mfilename\033[0m", 
            "P " + "\033[3mflight_code\033[0m", 
            "S " + "\033[3mflight_code class number_seats\033[0m", 
            "C " + "\033[3mreservation_code\033[0m", 
            "Q"
        );
        System.out.println(menu);
    }

    public String[] isValidInput(String input){  //código para cada tipo de comando
        String[] arguments = input.strip().split("\\s+");   // strips input then splits it by one or more spaces

        for (String arg : arguments) {
            System.out.printf("%s (%d)\n", arg, arg.length());
        }

        if (input.equals("H") || 
        input.matches("R\\s+.*") || 
        input.matches("P [A-Z]+[0-9]+") || 
        input.matches("S [A-Z]+[0-9]+ [TE] [1-9][0-9]*") || 
        input.matches("C [A-Z]+[0-9]+:[1-9][0-9]*") || 
        input.equals("Q")) {
        return arguments; // returns String[]
    }

    return new String[0]; // returns empty String[] (main program deals with this exception)
    }
}
