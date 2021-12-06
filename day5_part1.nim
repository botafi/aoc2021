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
    let scaleX = fX != tX
    let shouldSkip = if scaleX: fY != tY else: fX != tX
    if shouldSkip: continue
    let fromI = if scaleX: fX else: fY
    let toI = if scaleX: tX else: tY
    let sequence = if fromI <= toI: countup(fromI, toI).toSeq else: countdown(fromI, toI).toSeq
    for i in sequence:
        map[if scaleX: i else: fX][if scaleX: fY else: i] += 1
        if map[if scaleX: i else: fX][if scaleX: fY else: i] == 2:
             acc += 1
echo acc