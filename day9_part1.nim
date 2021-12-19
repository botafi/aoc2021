import std/sequtils
import strutils
import std/tables
import std/algorithm
import sugar
import math

let map = lines("data/input-day9.txt")
    .toSeq
    .map((line) => line.map((c) => ((uint8)c)-48))
var acc: uint = 0
for y, xLine in map:
    for x, height in xLine:
        if (x == 0 or height < xLine[x-1]) and
           (x == xLine.len - 1 or height < xLine[x+1]) and
           (y == 0 or height < map[y-1][x]) and
           (y == map.len - 1 or height < map[y+1][x]):
            acc += 1 + (uint)height
echo acc