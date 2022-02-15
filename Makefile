

BUILD_DIR = build/
TOOLS_DIR = tools/


all: alinka

bin: alinka code data

data: data.asm
	rasm -sq -s -o ${BUILD_DIR}data data.asm 
	python ${TOOLS_DIR}obfuscate.py ${BUILD_DIR}data.bin ${BUILD_DIR}data_obf.bin
	

code: alinka.asm data
	rasm -DRASM=1 -DNO_DATA=1 -l ${BUILD_DIR}data.sym -o ${BUILD_DIR}code alinka.asm
	rasm -DRASM=1 -DNO_DATA=1 -DOBFUSCATED=1 -l ${BUILD_DIR}data.sym -o ${BUILD_DIR}code_obf alinka.asm


alinka: alinka.asm data
	rasm -DRASM=1 -o ${BUILD_DIR}alinka alinka.asm
	rasm -DRASM=1 -DOBFUSCATED=1 -l ${BUILD_DIR}data.sym -o ${BUILD_DIR}alinka_obf alinka.asm

dsk: alinka.asm data
	rasm -DRASM=1 -DDSK=1 -eo alinka.asm
	rasm -DRASM=1 -DOBFUSCATED=1 -DDSK=1 -l ${BUILD_DIR}data.sym -eo alinka.asm

run: dsk
	cpc file=${BUILD_DIR}alinka.dsk input=run\"alinka\n

clean:
	rm -f ${BUILD_DIR}*


