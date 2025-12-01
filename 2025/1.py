from utils_2025 import *
debug = False

with open('input\\1.txt') as f:
    lines = f.read().splitlines()
print("total rows: ",len(lines))
initialSteps = 50
numberOfZeros=0
for row,line in enumerate(lines):
    firstChar = line[0]
    if firstChar == 'R':
        dir = 1
    else:
        if firstChar == 'L':
            dir = -1

    steps = int(line.split(firstChar)[1])
    printDebug("steps: " + str(steps),debug)
    printDebug("dir: " + str( dir),debug)
    stepsToTake = steps
    while stepsToTake > 0:
        stepsToTake -= 1
        initialSteps += dir
        if initialSteps > 99:
            initialSteps = 0
        if initialSteps < 0:
            initialSteps = 99
        
        if initialSteps == 0:
            printDebug("pointing at 0 "+ str(initialSteps),debug)
            numberOfZeros += 1
    printDebug("endpoint "+ str(initialSteps),debug)

print(numberOfZeros)
