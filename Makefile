

all: dsk

bin: alinka.bin

alinka.bin:
	rasm -DRASM=1 alinka.asm

dsk: alinka.bin
	ManageDsk -C  -AALINKA. -Ialinka.bin/ALINKA.BIN/BIN/16395/32357 -Salinka.dsk


clean:
	rm -f alinka.bin
	rm -f alinka.dsk
