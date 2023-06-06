# from algosdk import encoding
# import sys

# a = encoding.decode_address(sys.argv[1])
# print(a)

# print(encoding.decode_address('QT2GLKM6FSVHQMRQ53POMDBMCHH452FERI6WGNAT2J34KVRZPV6GA5DGOI'))

import sys
# import algosdk
from algosdk import encoding

address = sys.argv[1]
public_key = encoding.decode_address(address)
hex_public_key = public_key.hex()

print(hex_public_key)
print(hex_public_key.upper())
