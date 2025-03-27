package ex1;

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
	private static final long serialVersionUID = -3780928537820218865L;
	private JPanel jPanel = null;
	private JToggleButton bt[];
	JGaloInterface jogo ; 

	public JGalo(JGaloInterface myGreatGame) {
		super("Jogo da Galinha");
		jogo = myGreatGame;
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setSize(300,300);
        setLocation(100,100);
        jPanel = new JPanel();
		jPanel.setLayout(new GridLayout(3,3));
		bt = new JToggleButton[9];
		for (int i=0; i<9; i++) {
			bt[i] = new JToggleButton();
			bt[i].setFont(new Font("Tahoma", Font.BOLD, 50));
			bt[i].setForeground(Color.BLUE);
			bt[i].addActionListener(this);
			jPanel.add(bt[i]);				
		}
		  
		this.setContentPane(jPanel);
		setVisible(true);
	}

	public void actionPerformed(ActionEvent e) {
		if (e.getSource().getClass().getSimpleName().equals("JToggleButton")){
			((JToggleButton)e.getSource()).setText(String.valueOf(jogo.currentPlayer()));
			((JToggleButton)e.getSource()).setEnabled(false);
		}
		for (int i=0; i<9; i++)
			if (e.getSource()==bt[i]) {
				jogo.play(i/3+1,i%3+1);
			}

		if (jogo.finished()) {
			char result = jogo.result();
			if (result == ' ')
				JOptionPane.showMessageDialog(getContentPane(), "O jogo terminou empatado!");
			else
				JOptionPane.showMessageDialog(getContentPane(), "Venceu o jogador " + result);
			System.exit(0);
		}
	}

	public static void main(String args[]) {
		if (args.length == 0) {
			new JGalo(new Galo());
		} else if (args.length == 1) {
			if (!args[0].equals("x") && !args[0].equals("o")) {
				System.out.println("Argumento inválido");
				return;
			}
			new JGalo(new Galo(args[0].charAt(0)));
		} else {
			System.out.println("Número de argumentos inválido");
		}


	}
} 
