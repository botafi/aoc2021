import std/sequtils
import strutils

const newBornState = 8
const resetState = 6
const spawnState = 0
const simulateDays = 256
var input: seq[int] =
    lines("data/input-day6.txt")
    .toSeq[0]
    .split(",")
    .map(parseInt)
var stateGroups: array[spawnState..newBornState, uint64]
for state in input:
    stateGroups[state] += 1
echo stateGroups
for i in 1..simulateDays:
    var stateGroupsUpdate = stateGroups
    for state in spawnState..newBornState:
        let group = stateGroups[state]
        stateGroupsUpdate[if state == spawnState: resetState else: state-1] += group
        if state == spawnState:
            stateGroupsUpdate[newBornState] += group
        stateGroupsUpdate[state] -= group
    stateGroups = stateGroupsUpdate
echo stateGroups.foldl a + b