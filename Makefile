CRYSTAL_BIN ?= crystal
SHARDS_BIN ?= shards

.PHONY: clean distclean install lint test test_all

build: bin/lol-worlds-draw
bin/lol-worlds-draw:
	$(SHARDS_BIN) build $(CRFLAGS)
clean:
	rm -f ./bin/lol-worlds-draw ./bin/lol-worlds-draw.dwarf
distclean: clean
	rm -rf .crystal .shards libs lib bin
install:
	shards check || shards install
lint: install
	./bin/ameba --all
mutation_test: install
	./bin/crytic test
test:
	$(CRYSTAL_BIN) spec
test_all: install lint test mutation_test
