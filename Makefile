

DATA=0x400b
CODE=0x7e65


all: alinka

bin: alinka code data

data: data.asm
	rasm -DDATA_ADDR=${DATA} -sq -s -o data data.asm 

code: alinka.asm data
	rasm -DRASM=1 -DCODE_ADDR=${CODE} -DNO_DATA=1 -o code -l data.sym alinka.asm


alinka: alinka.asm data.asm
	rasm -DRASM=1 -DCODE_ADDR=${CODE} -DDATA_ADDR=${DATA} -o alinka alinka.asm

dsk: alinka.asm data.asm
	rasm -DRASM=1 -DCODE_ADDR=${CODE} -DDATA_ADDR=${DATA} -DDSK=1 -eo alinka.asm



clean:
	rm -f code.bin
	rm -f data.bin
	rm -f data.sym
	rm -f alinka.bin
	rm -f alinka.dsk


