def test(p1,p2=5,p3=10):
	return p1 + p2 + p3

if __name__ == "__main__":
	x = 1
	y = 1
	z = 1

	a = test(x,y,z)
	b = test(x,p3=z)
	c = test(x)
	d = test(x,p2=y)

	print(f"test(x,y,z) = {a}")
	print(f"test(x,p3=z) = {b}")
	print(f"test(x) = {c}")
	print(f"test(x,p2=y) = {d}")
