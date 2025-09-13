# Compiler and flags
CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -Iinclude
DEBUG_FLAGS = -g -O0
RELEASE_FLAGS = -O2 -DNDEBUG

# Directories
SRC_DIR = src
INCLUDE_DIR = include
BUILD_DIR = build
BIN_DIR = bin

# Source files
SOURCES = $(shell find $(SRC_DIR) -name "*.cpp")
HEADERS = $(shell find $(INCLUDE_DIR) -name "*.h")

# Object files
OBJECTS = $(SOURCES:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)

# Target executable
TARGET = $(BIN_DIR)/sql-engine

# Default target
.PHONY: all build debug release run clean format test help

all: build

# Build target
build: $(TARGET)

# Debug build
debug: CXXFLAGS += $(DEBUG_FLAGS)
debug: $(TARGET)

# Release build
release: CXXFLAGS += $(RELEASE_FLAGS)
release: $(TARGET)

# Create directories
$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

$(BIN_DIR):
	@mkdir -p $(BIN_DIR)

# Compile source files to object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Link object files to create executable
$(TARGET): $(OBJECTS) | $(BIN_DIR)
	$(CXX) $(OBJECTS) -o $@

# Run the executable
run: build
	@./$(TARGET)

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	@rm -rf $(BUILD_DIR) $(BIN_DIR)

# Format code
format:
	@echo "Formatting code..."
	@find . -name "*.cpp" -o -name "*.h" | xargs clang-format -i

# Run tests (placeholder - add your test framework here)
test:
	@echo "Running tests..."
	@echo "No tests configured yet"

# Show help
help:
	@echo "Available targets:"
	@echo "  all/build    - Build the project (default)"
	@echo "  debug        - Build with debug flags"
	@echo "  release      - Build with release flags"
	@echo "  run          - Build and run the executable"
	@echo "  clean        - Remove build artifacts"
	@echo "  format       - Format source code"
	@echo "  test         - Run tests"
	@echo "  help         - Show this help message"