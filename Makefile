.PHONY: run format

run:
	@mkdir -p bin
	@g++ src/main.cpp -o bin/sql-engine
	@./bin/sql-engine

format:
	@find . -name "*.cpp" -o -name "*.h" | xargs clang-format -i