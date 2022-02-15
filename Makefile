

DATA=0x400b
CODE=0x7e65

BUILD_DIR = build/
TOOLS_DIR = tools/


all: alinka

bin: alinka code data

data: data.asm
	rasm -DDATA_ADDR=${DATA} -sq -s -o ${BUILD_DIR}data data.asm 

code: alinka.asm data
	rasm -DRASM=1 -DCODE_ADDR=${CODE} -DNO_DATA=1 -o ${BUILD_DIR}code -l ${BUILD_DIR}data.sym alinka.asm


alinka: alinka.asm data.asm
	rasm -DRASM=1 -DCODE_ADDR=${CODE} -DDATA_ADDR=${DATA} -o ${BUILD_DIR}alinka alinka.asm

dsk: alinka.asm data.asm
	rasm -DRASM=1 -DCODE_ADDR=${CODE} -DDATA_ADDR=${DATA} -DDSK=1 -eo alinka.asm

run: dsk
	cpc.exe file=${BUILD_DIR}alinka.dsk input=run\"alinka\n

clean:
	rm -f ${BUILD_DIR}/*


