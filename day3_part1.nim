import std/bitops
import std/sequtils
import strutils

let fileLines = lines("data/input-day3.txt").toSeq
let length = fileLines[0].len
var gamma, epsilon = 0
for i in 0..length - 1:
    var zeroC = 0
    var oneC = 0
    for line in fileLines:
        case line[i]:
            of '1': inc oneC
            of '0': inc zeroC
            else: discard
    if zeroC < oneC:
        gamma.setBit(length - 1 - i)
    else:
        epsilon.setBit(length - 1 - i)
echo gamma * epsilon