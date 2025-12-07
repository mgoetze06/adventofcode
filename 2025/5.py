from utils_2025 import *
import re


debug = False

with open('input\\5.txt') as f:
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

def day5_part1(lines):
    ingredients = []
    rules = []
    for line in lines:
        line = line.strip()
        if "-" in line:
            rule = [int(x) for x in line.split("-")]
            rules.append(rule)
        else:
            if line != None and line != "":
                ingredients.append(int(line))

    validIngredients = 0
    for ingredient in ingredients:
        for rule in rules:
            if ingredient >= rule[0] and ingredient <= rule[1]:
                validIngredients += 1
                break

    print(validIngredients)
    return

def day5_part2(lines):
    #ingredients = []
    rules = []
    for line in lines:
        line = line.strip()
        if "-" in line:
            rule = [int(x) for x in line.split("-")]
            rules.append(rule)
        #else:
        #    if line != None and line != "":
        #        ingredients.append(int(line))

    validIngredients = 0
    validRanges = []
    for id,rule in enumerate(rules):
        lowerEdge = rule[0]
        higherEdge = rule[1]
        newLowerEdge = lowerEdge
        newHigherEdge = higherEdge
        print("checking rule:", rule)
        if len(validRanges) == 0:
            validRanges.append(rule)
            continue
        addingToValidRange = True
        for validRange in validRanges:
            if lowerEdge < validRange[0] and higherEdge > validRange[1]:
                print("removing range because it is into other range",validRange)
                validRanges.remove(validRange)
                addingToValidRange = True
            if lowerEdge >= validRange[0] and higherEdge <= validRange[1]:
                addingToValidRange = False

            if lowerEdge < validRange[1] and lowerEdge > validRange[0] and higherEdge > validRange[1]:
                newLowerEdge = validRange[1] + 1
                print("new lower edge:",newLowerEdge)
            if higherEdge > validRange[0] and higherEdge < validRange[1] and lowerEdge < validRange[0]:
                newHigherEdge = validRange[0] - 1
                print("new higher edge:",newHigherEdge)
        if addingToValidRange:
            validRanges.append([newLowerEdge,newHigherEdge])
        #print(validRanges)
    for validRange in validRanges:
        adding = 0
        if validRange[1] >= validRange[0]:
            adding = (validRange[1]-validRange[0]) + 1
        validIngredients += adding

    print(validIngredients)
    return

day5_part1(lines)
day5_part2(lines)