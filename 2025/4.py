from utils_2025 import *
import re


debug = False

with open('input\\4.txt') as f:
    lines = f.read().splitlines()
print("total rows: ",len(lines))

def findIndexOfBiggestDigitInString(string):
    n = 1
    parts = [int(string[i:i+n]) for i in range(0, len(string), n)]
    index = string.index(str(max(parts)))
    return index

def IsSearchIndexInsideMatrixBoundaries(position,matrix):
    
    if position[0] < 0:
        return False
    if position[1] < 0:
        return False
    if position[1] >=len(matrix):
        return False
    if position[0] >=len(matrix[0]):
        return False

    return True

def countOtherCharsNeighborhood(searchPosition,lines):
    #r-1,c-1    r-1,c   r-1,c+1
    #r,c-1      r,c     r,  c+1
    #r+1,c-1    r+1,c   r+1,c+1
    currentRolls = 0
    for r in range(-1,2,1):
        for c in range(-1,2,1):
            surroundingColumn = searchPosition[1] + c
            surroundingRow = searchPosition[0] + r
            if surroundingColumn == searchPosition[1] and surroundingRow == searchPosition[0]:
                printDebug("ignore",False)
            else:
                if IsSearchIndexInsideMatrixBoundaries([surroundingRow,surroundingColumn],lines):
                    char = lines[surroundingRow][surroundingColumn]
                    if char == charToSearch:
                        currentRolls += 1
    return currentRolls


charToSearch = '@'

def day4_part1(lines):
    rolls = 0
    for row,line in enumerate(lines):
        for column,char in enumerate(line):
            if char == charToSearch:
                if countOtherCharsNeighborhood([row,column],lines) < 4:
                    rolls += 1
    return rolls

def checkLines(lines,nextIterationLines):
    rolls = 0
    for row,line in enumerate(lines):
        for column,char in enumerate(line):
            if char == charToSearch:
                if countOtherCharsNeighborhood([row,column],lines) < 4:
                    rolls += 1
                    nextIterationLines[row] = nextIterationLines[row][:column] + "." + nextIterationLines[row][column+1:]
    return rolls,nextIterationLines

def day4_part2(lines):
    totalRolls = 0
    nextIterationLines = lines
    while True:
        newRolls,nextIterationLines = checkLines(lines,nextIterationLines)
        lines = nextIterationLines
        totalRolls += newRolls
        if newRolls == 0:
            print(totalRolls)
            break
    return

day4_part1(lines)
day4_part2(lines)