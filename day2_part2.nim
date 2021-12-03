import strscans

var depth, distance, aim = 0
for line in lines "data/input-day2.txt":
    var dir: string
    var len: int
    if not line.scanf("$+ $i", dir, len):
        break
    case dir:
        of "forward":
            distance += len
            depth += aim * len
        of "down":
            aim += len
        of "up":
            aim -= len
echo depth * distance