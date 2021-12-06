import std/sequtils
import strutils

const newBornState = 8
const resetState = 6
const simulateDays = 80
var states: seq[int] =
    lines("data/input-day6.txt")
    .toSeq[0]
    .split(",")
    .map(parseInt)
for i in 1..simulateDays:
    var buffer: seq[int] = @[]
    for state in states.mitems:
        state -= 1
        if state == -1:
            state = resetState
            buffer.add newBornState
    states.insert buffer
echo states.len