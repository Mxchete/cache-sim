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

report-a:
	@echo "Part A: MINIFE"
	@echo "8KB"
	@./sim 8192 4 0 1 tests/MINIFE.t
	@echo "16KB"
	@./sim 16384 4 0 1 tests/MINIFE.t
	@echo "32KB"
	@./sim 32768 4 0 1 tests/MINIFE.t
	@echo "64KB"
	@./sim 65536 4 0 1 tests/MINIFE.t
	@echo "128KB"
	@./sim 131072 4 0 1 tests/MINIFE.t
	@echo "Part A: XSBENCH"
	@echo "8KB"
	@./sim 8192 4 0 1 tests/XSBENCH.t
	@echo "16KB"
	@./sim 16384 4 0 1 tests/XSBENCH.t
	@echo "32KB"
	@./sim 32768 4 0 1 tests/XSBENCH.t
	@echo "64KB"
	@./sim 65536 4 0 1 tests/XSBENCH.t
	@echo "128KB"
	@./sim 131072 4 0 1 tests/XSBENCH.t

report-b:
	@echo "Part B: MINIFE"
	@echo "8KB"
	@./sim 8192 4 0 0 tests/MINIFE.t
	@echo "16KB"
	@./sim 16384 4 0 0 tests/MINIFE.t
	@echo "32KB"
	@./sim 32768 4 0 0 tests/MINIFE.t
	@echo "64KB"
	@./sim 65536 4 0 0 tests/MINIFE.t
	@echo "128KB"
	@./sim 131072 4 0 0 tests/MINIFE.t
	@echo "Part B: XSBENCH"
	@echo "8KB"
	@./sim 8192 4 0 0 tests/XSBENCH.t
	@echo "16KB"
	@./sim 16384 4 0 0 tests/XSBENCH.t
	@echo "32KB"
	@./sim 32768 4 0 0 tests/XSBENCH.t
	@echo "64KB"
	@./sim 65536 4 0 0 tests/XSBENCH.t
	@echo "128KB"
	@./sim 131072 4 0 0 tests/XSBENCH.t

report-c:
	@echo "Part C: MINIFE"
	@echo "1-way"
	@./sim 32768 1 0 1 tests/MINIFE.t
	@echo "2-way"
	@./sim 32768 2 0 1 tests/MINIFE.t
	@echo "4-way"
	@./sim 32768 4 0 1 tests/MINIFE.t
	@echo "8-way"
	@./sim 32768 8 0 1 tests/MINIFE.t
	@echo "16-way"
	@./sim 32768 16 0 1 tests/MINIFE.t
	@echo "32-way"
	@./sim 32768 32 0 1 tests/MINIFE.t
	@echo "64-way"
	@./sim 32768 64 0 1 tests/MINIFE.t
	@echo "Part C: XSBENCH"
	@echo "1-way"
	@./sim 32768 1 0 1 tests/XSBENCH.t
	@echo "2-way"
	@./sim 32768 2 0 1 tests/XSBENCH.t
	@echo "4-way"
	@./sim 32768 4 0 1 tests/XSBENCH.t
	@echo "8-way"
	@./sim 32768 8 0 1 tests/XSBENCH.t
	@echo "16-way"
	@./sim 32768 16 0 1 tests/XSBENCH.t
	@echo "32-way"
	@./sim 32768 32 0 1 tests/XSBENCH.t
	@echo "64-way"
	@./sim 32768 64 0 1 tests/XSBENCH.t

report-d:
	@echo "Part D: MINIFE"
	@echo "1-way"
	@./sim 32768 1 1 1 tests/MINIFE.t
	@echo "2-way"
	@./sim 32768 2 1 1 tests/MINIFE.t
	@echo "4-way"
	@./sim 32768 4 1 1 tests/MINIFE.t
	@echo "8-way"
	@./sim 32768 8 1 1 tests/MINIFE.t
	@echo "16-way"
	@./sim 32768 16 1 1 tests/MINIFE.t
	@echo "32-way"
	@./sim 32768 32 1 1 tests/MINIFE.t
	@echo "64-way"
	@./sim 32768 64 1 1 tests/MINIFE.t
	@echo "Part D: XSBENCH"
	@echo "1-way"
	@./sim 32768 1 1 1 tests/XSBENCH.t
	@echo "2-way"
	@./sim 32768 2 1 1 tests/XSBENCH.t
	@echo "4-way"
	@./sim 32768 4 1 1 tests/XSBENCH.t
	@echo "8-way"
	@./sim 32768 8 1 1 tests/XSBENCH.t
	@echo "16-way"
	@./sim 32768 16 1 1 tests/XSBENCH.t
	@echo "32-way"
	@./sim 32768 32 1 1 tests/XSBENCH.t
	@echo "64-way"
	@./sim 32768 64 1 1 tests/XSBENCH.t
