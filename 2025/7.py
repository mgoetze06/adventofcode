from utils_2025 import *
import re


debug = False

with open('input\\7.txt') as f:
    lines = f.read().splitlines()
print("total rows: ",len(lines))


def findStartingPoint(line):
    index = []
    index.append(line.index("S"))
    return index

def getNextSplitterPositions(line,oldSplitters):
    splitters = []
    for id,char in enumerate(line):
        if char == "^":
            #if id not in oldSplitters:
            splitters.append(id)
    return splitters

def getNewBeamPositions(splitters):
    beamPositions = []
    for splitter in splitters:
        if int(splitter)+1 not in beamPositions:
            beamPositions.append(int(splitter)+1)
        if int(splitter)-1 not in beamPositions:
            beamPositions.append(int(splitter)-1)
    return beamPositions

def intersectBeamPosition(newSplitterBeams,oldBeams):
    for newSplitterBeam in newSplitterBeams:
        if newSplitterBeam not in oldBeams:
            oldBeams.append(newSplitterBeam)


    return oldBeams

def removeOldBeamsAtSplitters(splitters,beams):
    splitted = 0
    for splitter in splitters:
        if splitter in beams:
            beams.remove(splitter)
            splitted += 1
    return beams,splitted

def day7_part1(lines):
    currentRow = 0
    beamPositions = findStartingPoint(lines[currentRow])
    splitters = []
    total = 0
    while currentRow < len(lines):
        if "^" in lines[currentRow]:
            #print(lines[currentRow])
            splitters = getNextSplitterPositions(lines[currentRow],splitters)
            newBeamsFromSplitters = getNewBeamPositions(splitters)
            #print("newbeams from splitters: ",newBeamsFromSplitters)

            beamPositions,splitted = removeOldBeamsAtSplitters(splitters,beamPositions)
            total += splitted
            #print("newBeams without splitters",beamPositions)
            beamPositions = intersectBeamPosition(newBeamsFromSplitters,beamPositions)
            #print("newbeams: ",beamPositions)
        currentRow += 1
    print(total)
def day7_part2(lines):

    return

day7_part1(lines)
day7_part2(lines)