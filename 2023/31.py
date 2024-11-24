def isSymbol(char):
    if char == "*":
        return True
    else:
        return False
    # if isDigit(char):
    #     return False
    
    #return True

def isDigit(char):
    if(char == "1" or char == "2" or char == "3" or char == "4" or char == "5" or char == "6" or char == "7" or char == "8" or char == "9" or char == "0"):
        return True
    
    return False

def getDigitPositions(symbol,data):
    row = symbol[0]
    col = symbol[1]
    output = []

    maxCols = len(data[0])
    maxRows = len(data)

    for rowOffset in range(-1,2,1):
    
        for colOffset in range(-1,2,1):
            if(not (colOffset == 0 and rowOffset == 0)):

                row_check = row + rowOffset
                col_check = col + colOffset
                #Write-Host "checking position: row: $row_check col: $col_check "
                if row_check < maxRows and row_check >= 0 and col_check >= 0 and col_check < maxCols:
                    if(isDigit(data[row_check][col_check])):
                        output.append([row_check,col_check])
    return output


def getNumberFromDigitPosition(digitPosition,data,usedPositions):
    row = digitPosition[0]
    col = digitPosition[1]
    startrow = row
    startcol = col

    maxCols = len(data[0])
    maxRows = len(data)

    if [row,col] in usedPositions:
        return -1,usedPositions
    
    outputString = ""
    currentChar = data[startrow][startcol]
    while(isDigit(currentChar)):
        outputString = outputString + currentChar
        usedPositions.append([row,col])
        col = col + 1
        if col >= maxCols:
            currentChar = "."
        else:
            currentChar = data[row][col]
            

    col = startcol - 1 
    currentChar = data[row][col]
    while(isDigit(currentChar)):
        outputString = currentChar + outputString
        usedPositions.append([row,col])
        col = col - 1
        if col < 0:
            currentChar = "."
        else:
            currentChar = data[row][col]
        


    return int(outputString),usedPositions

with open('31.txt') as f:
    lines = f.read().splitlines()

print("total rows: ",len(lines))
print("total cols: ",len(lines[0]))
symbols = []
for row,line in enumerate(lines):
    print(line)
    for col,char in enumerate(line):
        if isSymbol(char):
            symbols.append([row,col])


print("symbol positions: ",symbols)
digitPositions = []
for symbol in symbols:
    digitPositions.append(getDigitPositions(symbol,lines))


print(digitPositions)
usedPositions =[]
total = 0 
for digitsPerSymbol in digitPositions:
    gearratio = None
    numbers = []
    for digitPosition in digitsPerSymbol:
        print(digitPosition)
        number,usedPositions = getNumberFromDigitPosition(digitPosition,lines,usedPositions)
        if number != -1:
            numbers.append(number)

    if len(numbers) == 2:
        total += numbers[0]*numbers[1]


print(total)