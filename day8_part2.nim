import std/sequtils
import strutils
import std/tables
import std/algorithm
import sugar
import math

let knownSegCountMapping = {2:1,4:4,3:7,7:8}.toTable
var parsedLines =
    lines("data/input-day8.txt")
    .toSeq
    .map(func (line: string): (seq[string],seq[string]) =
        var split = line.split(" | ").map(part => part.splitWhitespace)
        for i in 0..1:
            for j in 0..split[i].len-1:
                split[i][j].sort(cmp)
        return (split[0], split[1])
    )
var sum = 0
for (digits, output) in parsedLines:
    var unscrambler = initTable[char, char]()
    var scrambler = initTable[char, char]()
    var intToDigitStr = initTable[int, string]()
    var digitStrToInt = initTable[string, int]()
    # find known ones by count
    for digit in digits:
        if knownSegCountMapping.hasKey(digit.len):
            intToDigitStr[knownSegCountMapping[digit.len]] = digit
            digitStrToInt[digit] = knownSegCountMapping[digit.len]
    while digitStrToInt.len != 10:
        for digit in digits:
            # find 6 using 1 - one not set
            if digit.len == 6 and not intToDigitStr.hasKey(6):
                let firstFound = digit.contains intToDigitStr[1][0]
                let secondFound = digit.contains intToDigitStr[1][1]
                if firstFound xor secondFound:
                    let scrambledC = if firstFound: intToDigitStr[1][1] else: intToDigitStr[1][0]
                    let scrambledF = if firstFound: intToDigitStr[1][0] else: intToDigitStr[1][1]
                    unscrambler[scrambledC] = 'c'
                    unscrambler[scrambledF] = 'f'
                    scrambler['c'] = scrambledC
                    scrambler['f'] = scrambledF
                    intToDigitStr[6] = digit
                    digitStrToInt[digit] = 6
            # find 2 using f segment missing
            if digit.len == 5 and not intToDigitStr.hasKey(2) and scrambler.hasKey('f') and not digit.contains(scrambler['f']):
                intToDigitStr[2] = digit
                digitStrToInt[digit] = 2
                let scrambledB = "abcdefg".filter(s => s != scrambler['f'] and not digit.contains(s))[0]
                unscrambler[scrambledB] = 'b'
                scrambler['b'] = scrambledB
            # find 5
            if digit.len == 5 and not intToDigitStr.hasKey(5) and intToDigitStr.hasKey(6) and scrambler.hasKey('c') and intToDigitStr[6] != digit and not digit.contains(scrambler['c']):
                intToDigitStr[5] = digit
                digitStrToInt[digit] = 5
                let scrambledE = "abcdefg".filter(s => s != scrambler['c'] and not digit.contains(s))[0]
                unscrambler[scrambledE] = 'e'
                scrambler['e'] = scrambledE
            # find 3
            if digit.len == 5 and not intToDigitStr.hasKey(3) and scrambler.hasKey('e') and scrambler.hasKey('b') and not digit.contains(scrambler['e']) and not digit.contains(scrambler['b']):
                intToDigitStr[3] = digit
                digitStrToInt[digit] = 3
            # find 9
            if digit.len == 6 and scrambler.hasKey('e') and not digit.contains(scrambler['e']):
                intToDigitStr[9] = digit
                digitStrToInt[digit] = 9
            # find 0
            if digit.len == 6 and scrambler.hasKey('e') and scrambler.hasKey('c') and digit.contains(scrambler['e']) and digit.contains(scrambler['c']):
                intToDigitStr[0] = digit
                digitStrToInt[digit] = 0
    for i, digit in output:
        sum += digitStrToInt[digit] * (10^(output.len - i - 1))
echo sum
