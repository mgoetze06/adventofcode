from utils_2025 import *
import re


debug = False

with open('input\\3.txt') as f:
    lines = f.read().splitlines()
print("total rows: ",len(lines))

def findIndexOfBiggestDigitInString(string):
    n = 1
    parts = [int(string[i:i+n]) for i in range(0, len(string), n)]
    index = string.index(str(max(parts)))
    return index

def day3_part1(lines):
    totalJoltage=0
    for row,line in enumerate(lines):
        stringWithoutLastChar = line[:len(line)-1]

        indexFirstChar = findIndexOfBiggestDigitInString(stringWithoutLastChar)
        printDebug(indexFirstChar,debug)
        biggestFirstChar = stringWithoutLastChar[indexFirstChar]
        printDebug(biggestFirstChar,debug)
        remainingString = line[indexFirstChar+1:]
        printDebug(remainingString,debug)
        indexSecondChar = findIndexOfBiggestDigitInString(remainingString)
        printDebug(indexSecondChar,debug)
        biggestSecondChar = remainingString[indexSecondChar]
        printDebug(biggestSecondChar,debug)

        joltage = int(str(biggestFirstChar+biggestSecondChar))
        printDebug(joltage,debug)
        totalJoltage += joltage

    print(totalJoltage)

def day3_part2(lines):
    totalJoltage = 0
    outputSize = 12
    for line in lines:
        leftBorder = 0
        rightBorder = 0
        outputString = ""
        for pick in range(outputSize):
            rightBorder = len(line) - outputSize + pick + 1
            window = line[leftBorder:rightBorder]
            index = findIndexOfBiggestDigitInString(window)
            digitPick = line[index+leftBorder]
            leftBorder = leftBorder + index + 1
            outputString = outputString + digitPick
        totalJoltage = totalJoltage + int(outputString)
    print(totalJoltage)
    return

day3_part1(lines)
day3_part2(lines)