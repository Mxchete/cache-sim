clean:
	@rm ./sim

build:
	@gcc -o sim -O2 -lm sim.c
