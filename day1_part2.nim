from std/strutils import parseInt
import std/sequtils

let lines = lines("data/input-day1.txt").toSeq.map(parseInt)
var n = 0
for i in 3..lines.len-1:
    let a = lines[i-1] + lines[i-2] + lines[i-3]
    let b = lines[i] + lines[i-1] + lines[i-2]
    if a < b:
        inc n
echo n