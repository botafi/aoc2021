import std/sequtils
import strutils

type Field = object
    value: int
    checked: bool
type FieldRef = ref Field
type Board = seq[seq[FieldRef]]
type Winner = tuple[board: Board, winningNumber: int]
func findLastWinningBoard(boards: seq[Board], selectedNumbers: seq[int]): Winner =
    var winnerIdxs = newSeq[bool](boards.len)
    var lastWinner: Winner = (@[], -1)
    for selectedNumber in selectedNumbers:
        for boardIdx, board in boards:
            if (winnerIdxs[boardIdx]): continue
            var hasWinningNumber = -1
            for line in board:
                var allChecked = true
                for field in line:
                    field.checked = field.checked or field.value == selectedNumber
                    allChecked = allChecked and field.checked
                if allChecked: hasWinningNumber = selectedNumber
            for columnIdx in 0..board.len - 1:
                var allChecked = true
                for line in board:
                    line[columnIdx].checked = line[columnIdx].checked or line[columnIdx].value == selectedNumber
                    allChecked = allChecked and line[columnIdx].checked
                if allChecked: hasWinningNumber = selectedNumber
            if hasWinningNumber != -1:
                winnerIdxs[boardIdx] = true
                lastWinner = (board, selectedNumber)
    return lastWinner
    
func parseBoards(lines: seq[string]): seq[Board] = 
    lines.map(func (line: string): seq[FieldRef] = 
        line
        .splitWhitespace
        .map(
            func (strN: string): FieldRef = FieldRef(value: parseInt(strN), checked: false)
        )
    )
    .distribute(int(lines.len/5))
func sumUnmarked(board: Board): int = foldl(
    board,
    foldl(b, a + (if b.checked: 0 else: b.value), a),
    0
) 

var fileLines = lines("data/input-day4.txt").toSeq
var selectedNumbers = fileLines[0].split(',').map(parseInt)
fileLines.delete(0)
var parsedBoards = fileLines
    .filter(func (line: string): bool = not line.isEmptyOrWhitespace)
    .parseBoards
let (board, winningNumber) = parsedBoards.findLastWinningBoard(selectedNumbers)
echo board.sumUnmarked * winningNumber