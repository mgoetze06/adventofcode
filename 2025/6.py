from utils_2025 import *
import re


debug = False

with open('input\\6.txt') as f:
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

def day6_part1(lines):
    input = []
    total = 0
    for id,line in enumerate(lines):
        #print(line.split(" "))
        filteredLine = line.split(" ")
        parsedInput = list(filter(None, filteredLine))
        #print(parsedInput)
        input.append(parsedInput)
        print(len(parsedInput))
        #print(input)

    for index in range(len(input[0])):
        operators = []
        operation = input[4][index]
        for i in range(4):
            operators.append(int(input[i][index]))            
        if operation == '*':
            result = operators[0] * operators[1] * operators[2] * operators[3]
        else:
            result = operators[0] + operators[1] + operators[2] + operators[3]

        total += result
    print(total)      
    return

def day6_part2(lines):
    input = []
    total = 0
    for id,line in enumerate(lines):
        #print(line.split(" "))
        filteredLine = line.split(" ")
        parsedInput = list(filter(None, filteredLine))
        #print(parsedInput)
        input.append(parsedInput)
        print(len(parsedInput))
        #print(input)

    for index in range(len(input[0])):
        operators = []
        operation = input[4][index]
        for i in range(4):
            operators.append(input[i][index])    


        if operation == '*':
            result = 0
            #result = operators[0] * operators[1] * operators[2] * operators[3]
        else:
            result = 0
            #result = operators[0] + operators[1] + operators[2] + operators[3]

        total += result
    print(total)     
    return

day6_part1(lines)
day6_part2(lines)