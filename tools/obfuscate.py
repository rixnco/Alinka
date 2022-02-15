import argparse

parser = argparse.ArgumentParser(description="Compress and obfuscate Alinka's data.")
parser.add_argument('in_file', help='binary data input filename')
parser.add_argument('out_file', help='compressed and obfuscated output filename')

args = parser.parse_args()



lines = 0xC6
width = 0x50

compressed = bytearray()
nbline = 0

print('reading "'+args.in_file+'"')

with open(args.in_file, "rb") as f:
  raw = bytearray(f.read(width))

  while len(raw)>0 and nbline<lines:
    nbline +=1
    zline = bytearray()
    cnt = 1
    val = raw[0]
    for x in raw[1:]:
      if x != val:
        zline.extend([cnt|0x80,val])
        cnt = 1
        val = x
      else:
        cnt +=1

    zline.extend([cnt|0x80,val,0xFF])
    raw[0:0]=[len(raw)]

    if(len(zline)>=len(raw)):
      zline = raw


    # print('{}:{:04X} {:02X}'.format(nbline, 1 + len(compressed), zline[0] ))
    compressed.extend(zline)

    raw = bytearray(f.read(width))

  compressed.extend(raw)
  raw = bytearray(f.read(width))
  compressed.extend(raw)


compressed[0:0]=[nbline]
# print('{:02X} - {:04X}'.format(nbline, len(compressed)))


len = 0x3b83
i = 0
while len>0:
  compressed[i] = compressed[i] ^ (len&0xFF)
  i +=1
  len -= 1

print('writing "'+args.out_file+'"')

with open(args.out_file, 'wb') as f:
  f.write(compressed)








