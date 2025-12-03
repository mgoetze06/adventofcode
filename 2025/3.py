from utils_2025 import *
debug = False

with open('input\\3_val.txt') as f:
    lines = f.read().splitlines()
print("total rows: ",len(lines))

def findIndexOfBiggestNumberInString(string):
    n = 1
    parts = [int(string[i:i+n]) for i in range(0, len(string), n)]
    index = string.index(str(max(parts)))
    return index

def day3_part1(lines):
    totalJoltage=0
    for row,line in enumerate(lines):
        stringWithoutLastChar = line[:len(line)-1]

        indexFirstChar = findIndexOfBiggestNumberInString(stringWithoutLastChar)
        biggestFirstChar = stringWithoutLastChar[indexFirstChar]
        remainingString = line[indexFirstChar+1:]
        indexSecondChar = findIndexOfBiggestNumberInString(remainingString)
        biggestSecondChar = line[indexSecondChar]

        joltage = int(str(biggestFirstChar+biggestSecondChar))
        totalJoltage += joltage

    print(totalJoltage)

def day3_part2(lines):
    print(lines)

day3_part1(lines)
day3_part2(lines)