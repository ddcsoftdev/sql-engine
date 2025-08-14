.PHONY: build run test clean lint


build:
	zig build

run: build
	zig build run

test:
	@echo "Running tests..."
	@find src -name "*.zig" -exec zig test {} \;

clean:
	rm -rf zig-out .zig-cache

lint: 
	@zig fmt .
