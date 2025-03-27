import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.io.IOException;

public class WSSolver {
	public static void main(String[] args) {
		// codigo para teste sem o terminal ou debug rapido
		if (args.length == 0) {
			args = new String[1];
			args[0] = "WordSearchSolver/sopa01.txt";
		}

		ArrayList<ArrayList<String>> data = readFile(args[0]);

		if (!verify(data)) {
			System.out.println("Dados inválidos");
			return;
		}

		// gerar matriz 15x15 da sopa de letras
		char[][] matriz = Matriz(data.get(0));

		List<String> palavras = data.get(2);
		for (String palavra : palavras) {
			palavras.set(palavras.indexOf(palavra), palavra.toLowerCase());
		}

		List<WordInfo> resultados = search(matriz, palavras);

		String outputFilename = args[0].replace(".txt", "_result.txt");
		printSolution(resultados, outputFilename);
	}


// métodos

	// ler dados do ficheiro
	public static ArrayList<ArrayList<String>> readFile(String filename) {
		// dados = [[puzzle], [comments], [palavras]]
		ArrayList<ArrayList<String>> dados = new ArrayList<ArrayList<String>>();

		ArrayList<String> puzzle = new ArrayList<String>();
		ArrayList<String> comments = new ArrayList<String>();
		ArrayList<String> chaves = new ArrayList<String>();

		try {
			File file = new File(filename);
			Scanner sc = new Scanner(file);
			int counter = 0;

			while (sc.hasNextLine()) {
				String line = sc.nextLine();

				if(counter < 15) {
					if (line.contains("#")) {
						String[] parts = line.split("#", 2);
						puzzle.add(parts[0].trim());

						// comentários sao irrelevantes neste problema mas separei os (o professor mencionou que fez na sua solução)
						comments.add(parts[1].trim());

					} else {
						puzzle.add(line.trim());
					}
				} else {
					if (line.contains("#")) {
						String[] parts = line.split("#", 2);
						comments.add(parts[1].trim());

						String[] k = parts[0].split(",|;|\\s");
						for (int i = 0; i < k.length; i++) {
							chaves.add(k[i]);
						}

					} else {
						String[] k = line.split(",|;|\\s");
						for (int i = 0; i < k.length; i++) {
							chaves.add(k[i]);
						}
					}
				}
				counter++;
			}
			sc.close();

		} catch (FileNotFoundException e) {
			System.out.println("An error occurred.");
			e.printStackTrace();
		}

		dados.add(puzzle);
		dados.add(comments);
		dados.add(chaves);

		return dados;
	}


	// verificar se as regras do problema são cumpridas
	public static Boolean verify(ArrayList<ArrayList<String>> data) {

		ArrayList<String> puzzle = data.get(0);

	// verificações relativas ao puzzle
		if (puzzle.size() != 15) {
			System.out.println("Altura do puzzle != 15");
			return false;
		}

		for (int i = 0; i < puzzle.size(); i++) {
			// retorna false se a linha está vazia
			if (puzzle.get(i).trim().isEmpty()) { // Verifica se a linha é vazia ou contém apenas espaços
				System.out.println("Erro: Linha " + (i + 1) + " do puzzle está vazia!");
				return false;
			}
			// retorna false se contiver caracteres diferentes de letras minusculas
			if (puzzle.get(i).matches(".*[^a-z].*")) {
				System.out.println("A linha " + (i + 1) + " do puzzle contém caracteres diferentes de letras minusculas");
				return false;
			}
			if (puzzle.get(i).length() != 15) {
				System.out.println("Largura do puzzle na linha " + (i+1) + " != 15");
				return false;
			}
		}

	// verificações relativas às chaves
		ArrayList<String> chaves = data.get(2);

		if (chaves.size() == 0) {
			System.out.println("O puzzle não tem palavras chave");
			return false;
		}

		for (int i = 0; i < chaves.size(); i++) {
			if (chaves.get(i).length() < 3) {
				System.out.println("Palavra chave «" + chaves.get(i) + "» tem menos de 3 caracteres");
				return false;
			}

			// falso se não começar por letra maiuscula
			if (!Character.isUpperCase(chaves.get(i).charAt(0))) {
				System.out.println("Palavra chave «" + chaves.get(i) + "» não começa por letra maiuscula");
				return false;
			}
		}

		return true;
	}


	// gerar matriz 15x15 da sopa de letras
	public static char[][] Matriz(List<String> sopa) {
	
		int linhas = sopa.size();
		int colunas = sopa.get(0).trim().length();
		char[][] matriz = new char[linhas][colunas];
	
		for (int i = 0; i < linhas; i++) {
			String txt = sopa.get(i).trim();
			matriz[i] = txt.toCharArray();
		}
	
		return matriz;
	}


    public static List<WordInfo> search(char[][] matriz, List<String> palavras) {
		List<WordInfo> results = new ArrayList<>();		

		palavras.sort((a, b) -> b.length() - a.length());

        for (String palavra : palavras) {
            for (int i = 0; i < matriz.length;i++) {
                for (int j = 0; j < matriz[i].length; j++) {
                    if (matriz[i][j] == Character.toLowerCase(palavra.charAt(0))) {
                        for (Directions direcao : Directions.values()) {
                            if (searchWord(matriz, palavra, i, j, direcao)) {
								results.add(new WordInfo(palavra, palavra.length(), i+1, j+1, direcao));
							}
                        }
                    }
                
                }
            }
        }
		return results;
    }

    public static boolean searchWord(char[][] matriz, String palavra, int linha, int coluna, Directions direcao) {
        int tamanho = palavra.length();

        int direcao_x = 0, direcao_y = 0;
        switch(direcao) {
            case Up:
                direcao_y = -1;
                break;
            case Down:
                direcao_y = 1;
                break;
            case Left:
                direcao_x = -1;
                break;
            case Right:
                direcao_x = 1;
                break;
            case UpLeft:
                direcao_x = -1;
                direcao_y = -1;
                break;
            case UpRight:
                direcao_x = 1;
                direcao_y = -1;
                break;
            case DownLeft:
                direcao_x = -1;
                direcao_y = 1;
                break;
            case DownRight:
                direcao_x = 1;
                direcao_y = 1;
                break;                
        }

        int x_atual = coluna;
        int y_atual = linha;

        for (int k = 1; k < tamanho; k++) {
            x_atual += direcao_x;
            y_atual += direcao_y;

            if (x_atual < 0 || y_atual < 0 || x_atual >= 15 || y_atual >= 15) {
                return false;
            }
            
            if (matriz[y_atual][x_atual] != palavra.charAt(k)) {
                return false;
            }

        }
        return true;
    }


    public static void printSolution(List<WordInfo> resultados, String outputFilename) {
		for (WordInfo wordInfo : resultados) {
			System.out.println(wordInfo);
		}

		System.out.println();

        char[][] solutionMatrix = new char[15][15];
        for (int i = 0; i < 15; i++) {
            for (int j = 0; j < 15; j++) {
                solutionMatrix[i][j] = '_';
            }
        }

        for (WordInfo wordInfo : resultados) {
            int x = wordInfo.getColumn() - 1;
            int y = wordInfo.getRow() - 1;
            String palavra = wordInfo.getWord();

            for (int k = 0; k < palavra.length(); k++) {
                if (x >= 0 && x < 15 && y >= 0 && y < 15) {
                    solutionMatrix[y][x] = Character.toUpperCase(palavra.charAt(k));
                } else {
                    System.out.println("erro");	// debug
                    break;
                }

                switch (wordInfo.getDirection()) {
                    case Up:
                        y--;
                        break;
                    case Down:
                        y++;
                        break;
                    case Left:
                        x--;
                        break;
                    case Right:
                        x++;
                        break;
                    case UpLeft:
                        y--;
                        x--;
                        break;
                    case UpRight:
                        y--;
                        x++;
                        break;
                    case DownLeft:
                        y++;
                        x--;
                        break;
                    case DownRight:
                        y++;
                        x++;
                        break;
                }
            }
        }

		int lastEmpty = 15, i, j, counter;
		for (i = 14; i >= 0; i--) {
			counter = 0;
			for (j = 0; j < 15; j++) {
				if (solutionMatrix[i][j] == '_') {
					counter++;
				}
			}

			if (counter == 15) {
				lastEmpty = i;
			} 
			if (counter != 15) {
				break;
			}
		}

        for (i = 0; i < lastEmpty; i++) {
            for (j = 0; j < 15; j++) {
                System.out.print(solutionMatrix[i][j] + " ");
            }
            System.out.println();
        }

		try (FileWriter output = new FileWriter(outputFilename)) {
			for (WordInfo wordInfo : resultados) {
				output.write(wordInfo + "\n");
			}
			output.write("\n");

			for (i = 0; i < lastEmpty; i++) {
				for (j = 0; j < 15; j++) {
					output.write(solutionMatrix[i][j] + " ");
				}
				output.write("\n");
			}
		} catch (IOException e) {
			System.out.println("Erro ao escrever no ficheiro");
			e.printStackTrace();
		}
    }
	

	public static List<String> getCoordinates(WordInfo wordInfo) {
		List<String> coordinates = new ArrayList<>();
		int row = wordInfo.getRow();
		int column = wordInfo.getColumn();
		int size = wordInfo.getLength();
		Directions direction = wordInfo.getDirection();

		for (int i = 0; i < size; i++) {
			switch (direction) {
				case Up:
					row--;
					break;
				case Down:
					row++;
					break;
				case Left:
					column--;
					break;
				case Right:
					column++;
					break;
				case UpLeft:
					row--;
					column--;
					break;
				case UpRight:
					row--;
					column++;
					break;
				case DownLeft:
					row++;
					column--;
					break;
				case DownRight:
					row++;
					column++;
					break;
			}
			coordinates.add(row + "," + column);
		}
		return coordinates;
	}
}