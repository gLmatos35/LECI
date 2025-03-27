// PDS, lab03 

import javax.swing.JFrame;
import javax.swing.JOptionPane;

import java.awt.Color;
import java.awt.Font;

import javax.swing.JPanel;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JToggleButton;

public class JGalo extends JFrame implements ActionListener {
	private static final long serialVersionUID = -3780928537820218865L; //no idea
	private JPanel jPanel = null;  //o objeto painel
	private JToggleButton bt[];  //botões para jogar
	JGaloInterface jogo ;  //a interface a criar para o jogo

	public JGalo(JGaloInterface myGreatGame) {  //construtor, não passa a interface,
                                                    //passa qualquer objeto que implementa
                                                    //essa interface
		super("Jogo da Galinha");  //construtor JFrame com a string como título
		jogo = myGreatGame;   //a interface argumento do construtor
                setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); //operação de encerramento do programa
		setSize(300,300);   //tamanho da JFrame
                setLocation(100,100);  //posição da JFrame
                jPanel = new JPanel();  //novo JPanel
		jPanel.setLayout(new GridLayout(3,3));  //grelha 3 por 3 no JPanel
		bt = new JToggleButton[9];  //criação de espaço de memória para 9 botões
		for (int i=0; i<9; i++) {
			bt[i] = new JToggleButton();  //instanciação de botão i
			bt[i].setFont(new Font("Tahoma", Font.BOLD, 50));
			bt[i].setForeground(Color.BLUE);
			bt[i].addActionListener(this);  //um listener para mudanças no botão
			jPanel.add(bt[i]);  //adicionar botão ao JPanel
		}

		this.setContentPane(jPanel);
		setVisible(true);
	}

	public void actionPerformed(ActionEvent e) {
		if (e.getSource().getClass().getSimpleName().equals("JToggleButton")){ //se houver atividade num dos botões
			((JToggleButton)e.getSource()).setText(String.valueOf(jogo.currentPlayer()));  //mudar o texto no botão para o símbolo do current player
			((JToggleButton)e.getSource()).setEnabled(false);  //dar disable ao botão para não anular jogadas
		}
		for (int i=0; i<9; i++){
			if (e.getSource()==bt[i]) {
				jogo.play(i/3+1,i%3+1); //transformação de numeração 1-9 para coordenadas 3x3
                                                        //assinalar local i,j como jogado
			}
                }

		if (jogo.finished()) {  //finished devolve true quando o jogo estiver terminado
			char result = jogo.result();  //espaço é empate, jogadores são O e X
			if (result == ' '){
				JOptionPane.showMessageDialog(getContentPane(), "O jogo terminou empatado!");
			}else{
				JOptionPane.showMessageDialog(getContentPane(), "Venceu o jogador " + result);
			}
                        System.exit(0);
		}
	}

	public static void main(String args[]) {
		new JGalo(new JGaloLogic());  //passar objeto de classe que implementa JGaloInterface

	}
} 
