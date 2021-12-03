import std/sequtils
import strutils

let fileLines = lines("data/input-day3.txt").toSeq
let length = fileLines[0].len

proc findByCommon(common: bool): int =
    var filteredLines = fileLines
    for i in 0..length - 1:
        var zeroC = 0
        var oneC = 0
        for line in filteredLines:
            case line[i]:
                of '1': inc oneC
                of '0': inc zeroC
                else: discard
        filteredLines = filteredLines.filter do (x: string) -> bool:
                    (zeroC <= oneC and x[i] == (if common: '1' else: '0')) or
                    (oneC < zeroC and x[i] == (if common: '0' else: '1')) 
        if filteredLines.len == 1:
            return filteredLines.pop.fromBin[:int]

echo findByCommon(false) * findByCommon(true)