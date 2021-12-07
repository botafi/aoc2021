import std/sequtils
import strutils
import std/stats
import sugar
import std/math

var positions: seq[float] =
    lines("data/input-day7.txt")
    .toSeq[0]
    .split(",")
    .map(parseFloat)
let avg = positions.mean
let before = positions.filter a => a < avg
let after = positions.filter a => a > avg
var avgPoint = (if before.len < after.len: after else: before).mean.round
let maxPosition = positions.max.toInt
func calculateFuel(fromN: SomeNumber, toN: SomeNumber): SomeNumber =
    let steps = abs(fromN - toN)
    return (steps + steps*steps) / 2;
var bestFuel = positions.foldl(a + calculateFuel(b, avgPoint), 0.0)
for step in 0..maxPosition:
    let up = positions.foldl(a + calculateFuel(b, (avgPoint + step.toFloat)), 0.0)
    let down = positions.foldl(a + calculateFuel(b, (avgPoint - step.toFloat)), 0.0)
    if up < down and up < bestFuel:
        bestFuel = up
    elif down <= up and down < bestFuel:
        bestFuel = down
echo bestFuel.toInt