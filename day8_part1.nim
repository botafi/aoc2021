import std/sequtils
import strutils
import std/tables
import sugar
let knownCountMapping = {2:1,4:4,3:7,7:8}.toTable
var screens =
    lines("data/input-day8.txt")
    .toSeq
    .map(line => line.split(" | ").map(part => part.splitWhitespace)[1])
echo screens
    .map(
        digits => digits.filter(digit => knownCountMapping.hasKey(digit.len)).len
    )
    .foldl(a + b)