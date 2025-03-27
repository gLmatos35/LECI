class WordInfo {
	String word;
	int length;
	int row;
	int column;
	Directions direction;

	public WordInfo(String word, int length, int row, int column, Directions direction) {
		this.word = word;
		this.length = length;
		this.row = row;
		this.column = column;
		this.direction = direction;
	}

	public String getWord() {
		return word;
	}

	public int getLength() {
		return length;
	}

	public int getRow() {
		return row;
	}

	public int getColumn() {
		return column;
	}

	public Directions getDirection() {
		return direction;
	}

	@Override
	public String toString() {
		return String.format("%-15s %-6d %-7s %s", 
							 word.toLowerCase(), length, column + "," + row, direction);
	}
	
}
