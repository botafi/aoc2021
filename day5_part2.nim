import std/sequtils
import sugar
import std/strscans

const mapLen = 1000
type Line = tuple[_: bool, fromX: int, fromY: int, toX: int, toY: int]
type Map = array[0..mapLen, array[0..mapLen, byte]]
var lines: seq[Line] = lines("data/input-day5.txt")
    .toSeq
    .map(line => scanTuple(line, "$i,$i -> $i,$i"))
var map: Map
var acc = 0
for (_, fX,fY,tX,tY) in lines:
    for x in 0..mapLen:
        for y in 0..mapLen:
            if (fX - tX) * (y - fY) == (fY - tY) * (x - fX) and
             x >= min(fX, tX) and
             x <= max(fX, tX) and
             y >= min(fY, tY) and
             y <= max(fY, tY):
                map[x][y] += 1
                if map[x][y] == 2:
                    acc += 1
echo acc