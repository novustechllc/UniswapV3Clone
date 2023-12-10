import sys
from eth_abi import encode

num = int(sys.argv[1])
num = str(bin(num))[2:]

if(sys.argv[2] == "least"):
    length = len(num)
    i = length - 1
    leastSignificantBit = 0
    while(i >= 0):
        if(num[i] == '1'):
            leastSignificantBit = length - 1 - i
            break
        i -= 1

    assert(leastSignificantBit < 256)
    assert(leastSignificantBit > -1)

    print("0x" + encode(["uint8"], [leastSignificantBit]).hex())
elif(sys.argv[2] == "most"):
    length = len(num)
    i = 0
    mostSignificantBit = 0
    while(i < length):
        if(num[i] == '1'):
            mostSignificantBit = length - i - 1
            break
        i += 1

    assert(mostSignificantBit < 256)
    assert(mostSignificantBit > -1)

    print("0x" + encode(["uint8"], [mostSignificantBit]).hex())