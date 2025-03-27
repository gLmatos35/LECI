public class JGaloGame implements JGaloInterface{
  private final Tabuleiro tabuleiro;
  private final Jogador jogadorX;
  private final Jogador jogadorO;
  private Jogador jogadorAtual;
  private boolean gameFinished;


  public JGaloGame(char firstPlayer){
      tabuleiro = new Tabuleiro();
      jogadorX = new Jogador('X');
      jogadorO = new Jogador('O');
      jogadorAtual = new Jogador(firstPlayer);

      if(firstPlayer == 'X'){
          jogadorAtual = jogadorX;
      }else{
          jogadorAtual = jogadorO;
      }
      
      gameFinished = false;

  }

  @Override
  public char currentPlayer(){
      return jogadorAtual.getLetra();
  }

  @Override
  public boolean play(int row,int col){

      if(!tabuleiro.jogadaValida(row, col) || gameFinished == true){
          return false;
      }

      tabuleiro.jogar(row, col, currentPlayer());

      if(tabuleiro.checkWin(currentPlayer())){
          gameFinished = true;
      }else if(tabuleiro.isBoardFull()){
          gameFinished = true;
      }else{
          // trocar
          if(jogadorAtual == jogadorX){
              jogadorAtual = jogadorO;
          }else{
              jogadorAtual = jogadorX;
          }
      }
      return true;
  }

  @Override
  public boolean finished(){
      return gameFinished;
  }

  @Override
  public char result(){
      if(tabuleiro.checkWin('X')){
          return 'X';
      }
      if (tabuleiro.checkWin('O')){
          return 'O';
      }
      if(tabuleiro.isBoardFull()){
          return ' ';
      }
      return '\0';
  }



}
