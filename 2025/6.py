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

def getMaximumLength(column):
    maxLength = 0
    for item in column:
        length = len(item.replace(" ",""))
        if length > maxLength:
            maxLength = length
    return maxLength

def buildOperators(column,length):
    operators = []
    for index in range(length):
        digitString = ""
        for item in column:
            if "*" in item or "+" in item:
                continue
            if item[index] != None and item[index] != " ":
                digitString = digitString + item[index]

        operators.append(int(digitString))
    return operators

def computeColumnResult(column):
    length = getMaximumLength(column)
    operators = buildOperators(column,length)
    operation = column[-1].replace(" ","")
    if operation == '*':
        result = 1
        for i in range(len(operators)):
            result = result*operators[i]
    else:
        if operation == '+':
            result = 0
            for i in range(len(operators)):
                result += operators[i]
        else:

            print("no operation found")
            return 0
        
    return result

def day6_part2(lines):
    input = []
    total = 0
    columnStartIndex = 0
    for index,char in enumerate(lines[0]):
        if char == " " and lines[1][index] == " " and lines[2][index] == " " and lines[3][index] == " ":
            column = [lines[0][columnStartIndex:index],lines[1][columnStartIndex:index],lines[2][columnStartIndex:index],lines[3][columnStartIndex:index],lines[4][columnStartIndex:index]]
            columnStartIndex = index + 1
            result = computeColumnResult(column)
            total += result
    column = [lines[0][columnStartIndex:],lines[1][columnStartIndex:],lines[2][columnStartIndex:],lines[3][columnStartIndex:],lines[4][columnStartIndex:]]
    result = computeColumnResult(column)
    total += result
    print(total)
    return

day6_part1(lines)
day6_part2(lines)