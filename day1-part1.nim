from std/strutils import parseInt
import options

var prevLineN: Option[int] = none(int)
var n = 0
for currLine in lines "data/input-day1.txt":
    let currLineN = parseInt currLine
    if prevLineN.isSome and prevLineN.get < currLineN:
        inc n
    prevLineN = some(currLineN)
echo n