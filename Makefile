

all: bin

bin: alinka.bin

alinka.bin: alinka.asm data.asm
	rasm -DRASM=1 alinka.asm

dsk: alinka.asm data.asm
	rasm -DRASM=1 -DDSK=1 -eo alinka.asm



clean:
	rm -f alinka.bin
	rm -f alinka.dsk


