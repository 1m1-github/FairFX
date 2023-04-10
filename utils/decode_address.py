from algosdk import encoding
import sys

a = encoding.decode_address(sys.argv[1])
print(a)