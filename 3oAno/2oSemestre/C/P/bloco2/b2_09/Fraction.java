package b2_09;

public class Fraction {
	
	public Fraction() {
		this.num = 0;
		this.den = 1;
	}

	public Fraction(Fraction)

	protected int mdc(int a, int b) {
		int res = a;
		if (b != 0) {
			res = mdc(b, a%b);
		}
		return res;
	}

	public int num() {
		return num;
	}

	@Override
	public String toString() {
		return "";
	} 

	protected int num,den;
}
