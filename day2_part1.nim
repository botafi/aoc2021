import strscans

var depth, distance = 0
for line in lines "data/input-day2.txt":
    var dir: string
    var len: int
    if not line.scanf("$+ $i", dir, len):
        break
    case dir:
        of "forward":
            distance += len
        of "down":
            depth += len
        of "up":
            depth -= len
echo depth * distance