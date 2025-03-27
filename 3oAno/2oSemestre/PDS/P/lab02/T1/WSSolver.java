public class WSSolver {
    //public ArrayList<String> findWords(Sopa sopa) {
    public char[][] findWords(Sopa sopa) {
        // Inicialização da tabela vazia
        char[][] result = new char[15][15];
        for (int i=0; i<15; i++) {
            for (int j=0; j<15; j++) {
                result[i][j] = '_';
            }
        }

        boolean flag = true;

        char[][] tabela = sopa.getCaracteres();
        // Pesquisar palavras
        for (int p=0; p<sopa.getPalavras().size(); p++) {
            String palavra = sopa.getPalavras().get(p);
            //System.out.printf("PALAVRAS: " + sopa.getPalavras() + "\n");
            int palavra_size = palavra.length();
            //System.out.printf("PALAVRA: %s\n", palavra);

            flag = true;

            // Pesquisa da sequência dos diversos caracteres
            //for (int c=0; c<palavra.length(); c++) {
                //char caracter = palavra.charAt(c);
                char caracter = palavra.charAt(0);
                for (int i=0; i<15; i++) {
                    if(!flag){
                        break;
                    }
                    for(int j= 0;j<15;j++){
                        if(!flag){
                            break;
                        }

                        if (tabela[i][j] == caracter) {
                            //System.out.println("POS: i=" + i + ", j=" + j);
                            String aux = Character.toString(caracter);
                            int temp_i = i;
                            int temp_j = j;

                            // Verificar periferia
                            if (i+1-palavra_size >= 0) { // Verifica para cima
                                temp_i--;
                                if (j+1-palavra_size >= 0) {  // Verificação para a esquerda (UPLEFT)
                                    //System.out.println("UPLEFT");
                                    temp_j--;
                                    while (palavra.startsWith(aux) && !palavra.equals(aux)) {
                                        aux = aux + tabela[temp_i--][temp_j--];
                                        //System.out.println(aux);   // PRINT PARA WORDS
                                    }
                                    //System.out.println(aux);
                                    if(palavra.equals(aux)){
                                        for(int k = 0;k<palavra_size;k++){
                                            result[++temp_i][++temp_j] = palavra.toUpperCase().charAt(palavra_size-1-k);
                                            //System.out.println(palavra.toUpperCase().charAt(k));
                                        }
                                        flag = false;
                                        break;
                                    }
                                    temp_i = i-1;
                                    temp_j = j;
                                    aux = Character.toString(caracter);
                                }

                                if (15-(j+1)-palavra_size >= 0) {  // Verificação para a direita (UPRIGHT)
                                    //System.out.println("UPRIGHT");
                                    temp_j++;
                                    while (palavra.startsWith(aux) && !palavra.equals(aux)) {
                                        aux = aux + tabela[temp_i--][temp_j++];
                                    }
                                    //System.out.println(aux);
                                    if(palavra.equals(aux)){
                                        for(int k = 0;k<palavra_size;k++){
                                            result[++temp_i][--temp_j] = palavra.toUpperCase().charAt(palavra_size-1-k);
                                            //System.out.println(palavra.toUpperCase().charAt(k));
                                        }
                                        flag = false;
                                        break;
                                    }
                                    temp_i = i-1;
                                    temp_j = j;
                                    aux = Character.toString(caracter);
                                }

                                // Verificação vertical (UP)
                                //System.out.println("UP");
                                while (palavra.startsWith(aux) && !palavra.equals(aux)) {
                                    aux = aux + tabela[temp_i--][temp_j];
                                    //System.out.println(aux);   // PRINT PARA PROGRAMMING
                                }
                                //System.out.println(aux);
                                if(palavra.equals(aux)){
                                    for(int k = 0;k<palavra_size;k++){
                                        result[++temp_i][temp_j] = palavra.toUpperCase().charAt(palavra_size-1-k);
                                        //System.out.println(palavra.toUpperCase().charAt(k));
                                    }
                                    flag = false;
                                    break;
                                }
                                temp_i = i;
                                temp_j = j;
                                aux = Character.toString(caracter);
                            }

                            if (15-(i+1)-palavra_size >= 0) {    // Verifica para baixo
                                temp_i++;
                                if (j+1-palavra_size >= 0) {  // Verificação para a esquerda (DOWNLEFT)
                                    //System.out.println("DOWNLEFT");
                                    temp_j--;
                                    while (palavra.startsWith(aux) && !palavra.equals(aux)) {
                                        aux = aux + tabela[temp_i++][temp_j--];
                                    }
                                    //System.out.println(aux);
                                    if(palavra.equals(aux)){
                                        for(int k = 0;k<palavra_size;k++){
                                            result[--temp_i][++temp_j] = palavra.toUpperCase().charAt(palavra_size-1-k);
                                            //System.out.println(palavra.toUpperCase().charAt(k));
                                        }
                                        flag = false;
                                        break;
                                    }
                                    temp_i = i+1;
                                    temp_j = j;
                                    aux = Character.toString(caracter);
                                }
                                if (15-(j+1)-palavra_size >= 0) {  // Verificação para a direita (DOWNRIGHT)
                                    //System.out.println("DOWNRIGHT");
                                    temp_j++;
                                    while (palavra.startsWith(aux) && !palavra.equals(aux)) {
                                        aux = aux + tabela[temp_i++][temp_j++];
                                    }
                                    //System.out.println(aux);
                                    if(palavra.equals(aux)){
                                        for(int k = 0;k<palavra_size;k++){
                                            result[--temp_i][--temp_j] = palavra.toUpperCase().charAt(palavra_size-1-k);
                                            //System.out.println(palavra.toUpperCase().charAt(k));
                                        }
                                        flag = false;
                                        break;
                                    }
                                    temp_i = i+1;
                                    temp_j = j;
                                    aux = Character.toString(caracter);
                                }
                                // Verificação vertical (DOWN)
                                //System.out.println("DOWN");
                                while (palavra.startsWith(aux) && !palavra.equals(aux)) {
                                    aux = aux + tabela[temp_i++][temp_j];
                                }
                                //System.out.println(aux);
                                if(palavra.equals(aux)){
                                    for(int k = 0;k<palavra_size;k++){
                                        result[--temp_i][temp_j] = palavra.toUpperCase().charAt(palavra_size-1-k);
                                        //System.out.println(palavra.toUpperCase().charAt(k));
                                    }
                                    flag = false;
                                    break;
                                }
                                temp_i = i;
                                temp_j = j;
                                aux = Character.toString(caracter);
                            }

                            // Verifica horizontal
                            if (j+1-palavra_size >= 0) {  // Verificação para a esquerda (LEFT)
                                //System.out.println("LEFT");
                                temp_j--;
                                while (palavra.startsWith(aux) && !palavra.equals(aux)) {
                                    aux = aux + tabela[temp_i][temp_j--];
                                }
                                //System.out.println(aux);
                                if(palavra.equals(aux)){
                                    for(int k = 0;k<palavra_size;k++){
                                        result[temp_i][++temp_j] = palavra.toUpperCase().charAt(palavra_size-1-k);
                                        //System.out.println(palavra.toUpperCase().charAt(k));
                                    }
                                    flag = false;
                                    break;
                                }
                                temp_i = i;
                                temp_j = j;
                                aux = Character.toString(caracter);
                            }
                            if (15-(j+1)-palavra_size >= 0) {  // Verificação para a direita (RIGHT)
                                //System.out.println("RIGHT");
                                while (palavra.startsWith(aux) && !palavra.equals(aux)) {
                                    aux = aux + tabela[temp_i][++temp_j];
                                    //System.out.println(tabela[temp_i][temp_j]);
                                    //System.out.println(aux);
                                }
                                //System.out.println(aux);
                                if(palavra.equals(aux)){
                                    temp_j++;
                                    for(int k = 0;k<palavra_size;k++){
                                        result[temp_i][--temp_j] = palavra.toUpperCase().charAt(palavra_size-1-k);
                                        //System.out.println(palavra.toUpperCase().charAt(k));
                                    }
                                    flag = false;
                                    break;
                                }
                                temp_i = i;
                                temp_j = j;
                                aux = Character.toString(caracter);
                            }
                        }
                    }
                }
            //}
        }

        return result;
    }
}

