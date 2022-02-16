default: install

.PHONY install

install:
	git submodule update --init --recursive
