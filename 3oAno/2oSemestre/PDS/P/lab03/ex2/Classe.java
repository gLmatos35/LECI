package ex2;

public enum Classe {
	E("Executiva"),
	T("Turistica");

	private final String classe;

	Classe(String classe) {
		this.classe = classe;
	}

	public String getClasse() {
		return classe;
	}
}


