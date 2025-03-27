package ex2;

import java.util.ArrayList;

public class Plane {
	private int execRows;
	private int execSeatsPerRow;
	private int turRows;
	private int turSeatsPerRow;
	private int freeExecSeats;
	private int freeTurSeats;
	
	private ArrayList<ArrayList<Integer>> planeConfig;
	// planeConfig inicial (tudo a zeros) para, por ex, 2x2:5x3
	// [[0,0],[0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]]

	public Plane(String configExec, String configTur) {
		if (configExec == null) {
			this.execRows = 0;
			this.execSeatsPerRow = 0;
		} else {
			this.execRows = getConfigRows(configExec);
			this.execSeatsPerRow = getConfigSeatsPerRow(configExec);
		}
		this.freeExecSeats = execRows * execSeatsPerRow;

		this.turRows = getConfigRows(configTur);
		this.turSeatsPerRow = getConfigSeatsPerRow(configTur);
		this.freeTurSeats = turRows * turSeatsPerRow;

		this.planeConfig = new ArrayList<ArrayList<Integer>>();
		generateSeatConfig(execRows, execSeatsPerRow, turRows, turSeatsPerRow);
	}

	public ArrayList<ArrayList<Integer>> getPlaneConfig() {
		return this.planeConfig;
	}

	public int getExecRows() {
		return this.execRows;
	}

	public int getTurRows() {
		return this.turRows;
	}

	public int getFreeExecSeats() {
		return this.freeExecSeats;
	}

	public int getFreeTurSeats() {
		return this.freeTurSeats;
	}

	public int getConfigRows(String config) {
		String[] data = config.split("x");
		return Integer.parseInt(data[0]);
	}

	public int getConfigSeatsPerRow(String config) {
		String[] data = config.split("x");
		return Integer.parseInt(data[1]);
	}



	public void generateSeatConfig(int execRows, int execSeatsPerRow, int turRows, int turSeatsPerRow) {
		if (execRows != 0 && execSeatsPerRow != 0) {
			// primeiro executivos, depois turisticos
			// ideia pretendida explicada acima abaixo da declaracao de planeConfig
			for (int i = 0; i < execRows; i++) {
				ArrayList<Integer> row = new ArrayList<Integer>();
				for (int j = 0; j < execSeatsPerRow; j++) {
					row.add(0);
				}
				// adicionar a row ao planeConfig
				planeConfig.add(row);
			}

			// turisticos
			for (int i = 0; i < turRows; i++) {
				ArrayList<Integer> row = new ArrayList<Integer>();
				for (int j = 0; j < turSeatsPerRow; j++) {
					row.add(0);
				}
				planeConfig.add(row);
			}

		} else {
			// turisticos
			for (int i = 0; i < turRows; i++) {
				ArrayList<Integer> row = new ArrayList<Integer>();
				for (int j = 0; j < turSeatsPerRow; j++) {
					row.add(0);
				}
				planeConfig.add(row);
			}
		}
	}

	public void fillSeat(Seat lugar, int numeroReserva) {
		// ex: lugar 4C -> planeConfig[3][2]
		int row = lugar.getRow() - 1;
		int letter = (int) lugar.getLetter() - (int) 'A';

		if (lugar.getClasse() == Classe.E) {
			planeConfig.get(row).set(letter, numeroReserva);
			freeExecSeats--;
		} else {
			// System.out.println("vou morrer aqui");
			planeConfig.get(row).set(letter, numeroReserva);

			freeTurSeats--;
		}
	}

	public void freeSeat(Seat lugar) {
		int row = lugar.getRow() - 1;
		int letter = (int) lugar.getLetter() - (int) 'A';

		if (lugar.getClasse() == Classe.E) {
			planeConfig.get(row).set(letter, 0);
			freeExecSeats++;
		} else {
			planeConfig.get(row).set(letter, 0);
			freeTurSeats++;
		}
	}

	public boolean validateBooking(Classe c, int numReservas) {
		if(c == Classe.E && (getFreeExecSeats() < numReservas)) {
			System.out.println("Não foi possível obter lugares para a reserva: " + c + " " + numReservas);
			return false;
		} else if (c == Classe.T && (getFreeTurSeats() < numReservas)) {
			System.out.println("Não foi possível obter lugares para a reserva: " + c + " " + numReservas);
			return false;
		}

        return true;
    }

	public void displaySeats() {
		char letter = 'A';
		int numLetters = execSeatsPerRow > turSeatsPerRow ? execSeatsPerRow : turSeatsPerRow;

		System.out.print("  ");
		for (int i = 1; i <= planeConfig.size(); i++) {
			System.out.print(String.format("%3d", i));
		}

		for (int i = 0; i < numLetters; i++) {
			System.out.print(String.format("\n%-2s", letter));

			for (int j = 0; j < planeConfig.size(); j++) {
				if (planeConfig.get(j).size() > i) {
					System.out.print(String.format("%3d", planeConfig.get(j).get(i)));
				} else {
					System.out.print("   ");
				}
			}
			letter++;
		}
		System.out.println();
	}
}
