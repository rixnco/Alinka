




i = 0
val=''
while i<256:
  if (i & 0xAA) and (i & 0x55):
     val = 'PXL_B'
  elif (i & 0xAA):
    val = 'PXL_L'
  elif (i & 0x55):
    val = 'PXL_R'
  else:
    val = 'PXL_Z'
  

  if (i % 8) == 0:
    print('\n\tdb ', end='')
  else:
    print(',', end='')
  
  print(val,end='')

  i += 1
