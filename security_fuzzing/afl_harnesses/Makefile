CC = afl-clang-fast
CFLAGS = -O2 -g -Wall
LDFLAGS = -L../../core_systems/build -lcuda_acceleration -lzig_utils

TARGET = harness_io
SRC = harness_io.c

all: $(TARGET)

$(TARGET): $(SRC)
	@echo "[*] Instrumenting target with AFL++ compiler..."
	$(CC) $(CFLAGS) $(SRC) -o $(TARGET) $(LDFLAGS)
	@echo "[+] Fuzzing harness successfully instrumented."

clean:
	rm -f $(TARGET)
