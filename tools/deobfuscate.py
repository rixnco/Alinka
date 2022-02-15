import argparse

parser = argparse.ArgumentParser(description="Deobfuscate and 'decompress' Alinka's data.")
parser.add_argument('in_file', help='obfuscated and compressed input filename')
parser.add_argument('out_file', help='deobfuscated and decompressed output filename')

args = parser.parse_args()

print('reading "'+args.in_file+'"')

with open(args.in_file, "rb") as f:

  obf = bytearray(f.read())

  key = 0x3b83
  i = 0
  while key>0:
    obf[i] = obf[i] ^ (key&0xFF)
    i +=1
    key -= 1

  out = bytearray()

  length = len(obf)

  nbline = obf[0]
  obf = obf[1:]
  
  line = 0
  while nbline>0:
    line += 1
    nbline -=1

    w = obf[0]
    obf = obf[1:]

    while w != 0xFF:
      if w & 0x80 != 0 :
        w = w & 0x7f
        val = obf[0]
        out.extend([val]*w)
        obf = obf[1:]
        w = obf[0]
        obf = obf[1:]
      else:
        d = obf[0:w]
        out.extend(d)
        obf = obf[w:]
        break
  
  out.extend(obf)


print('writing "'+args.out_file+'"')

with open(args.out_file, 'wb') as f:
  f.write(out)


    





