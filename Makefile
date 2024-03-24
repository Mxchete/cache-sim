clean:
	@rm ./sim

build:
	@gcc -o sim -O2 -lm sim.c

test:
	@make build
	@echo "real output: "
	@./sim 32768 8 0 0 tests/smallTest.t
	@echo "Expected Output:"
	@echo "Miss ratio 0.143000"
	@echo "write 392"
	@echo "read 143"
	@echo " "
	@echo "real output: "
	@./sim 32768 8 0 0 tests/mediumTest.t
	@echo "Expected Output:"
	@echo "Miss ratio 0.112800"
	@echo "write 2537"
	@echo "read 1128"
	@echo ""
	@echo "real output: "
	@./sim 32768 8 0 1 tests/mediumTest.t
	@echo "Expected Output:"
	@echo "Miss ratio 0.112800"
	@echo "write 34"
	@echo "read 1128"
	@echo ""
	@echo "real output: "
	@./sim 32768 8 1 0 tests/mediumTest.t
	@echo "Expected Output:"
	@echo "Miss ratio 0.117800"
	@echo "write 2537"
	@echo "read 1178"
	@echo ""
	@echo "real output: "
	@./sim 32768 8 0 1 tests/XSBENCH.t
	@echo "Expected Output:"
	@echo "Miss ratio 0.112008"
	@echo "write 44"
	@echo "read 2371758"
	@echo ""
	@echo "real output: "
	@./sim 32768 8 0 0 tests/XSBENCH.t
	@echo "Expected Output:"
	@echo "Miss ratio 0.112008"
	@echo "write 5013495"
	@echo "read 2371758"
