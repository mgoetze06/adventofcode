from utils_2025 import *
import re


debug = False

with open('input\\3_val.txt') as f:
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

def deaktiviereStringErmittleMaximum(deaktiviert_Index, stringToCheck):
    maxValue = 0
    originalString = stringToCheck
    if len(deaktiviert_Index)==0:
        return 0
    charToReplace = stringToCheck[deaktiviert_Index[0]]
    string = "0"
    for performReplacement in range(1,len(deaktiviert_Index)):
        string = originalString.replace(charToReplace,'',performReplacement)
        #print(string)
        if len(string)<12:
            return 0
        if len(string)==12:
            break
        
        if len(string)>12:
            string = string[0:12]

        value = int(string)
        if value > maxValue:
            maxValue = value
    value = int(string)
    if value > maxValue:
        maxValue = value
    return maxValue



def day3_part2(lines):
    totalJoltage = 0
    for line in lines:
        print("")
        print("neue Zeile:" , line)
        maxValue = 0
        for i in range(9,0,-1):
            print("")
            print("startpunktNum",i)
            startpunkte = [match.start() for match in re.finditer(str(i), line)]
            startpunkte.sort(reverse=True)
            print("startpunkte: ",startpunkte)
            for startpunkt in startpunkte:
                stringToCheck = line[startpunkt:]
                for deaktiviertesDigit in range(1,9):
                    deaktiviert = [match.start() for match in re.finditer(str(deaktiviertesDigit), stringToCheck)]
                    value = deaktiviereStringErmittleMaximum(deaktiviert,stringToCheck)
                    if value > maxValue:
                        maxValue = value
                        print("maxvalue: ",maxValue)
        totalJoltage += maxValue
    
    print(totalJoltage)
    return

#day3_part2 notes
# 12 digit output
# start checking at biggest digit, where more than 11 chars to the right
# always only check to the right
# start with lowest digit in remaining string
#   disable from start to the right only this digit
#    


#day3_part1(lines)
day3_part2(lines)