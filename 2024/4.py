import re
with open('./input/4.txt') as f:
    lines = f.readlines()
print("total rows: ",len(lines))
#print(lines[0])

#lines = ["....." + l.strip() + "....." for l in lines]
lines = ["....." + l.strip() + "....." for l in lines]

paddingRow = "".join(["." for l in lines[0]])
print(paddingRow)
for i in range(5):
    lines.insert(0,paddingRow)
    lines.append(paddingRow)

#lines = "."*len(lines)
#lines = "".join(lines)

def getCharFromPosition(localposition,lines):
    maxRow = len(lines)-1
    maxCol = len(lines[0])-1
    
    # if len(localposition) != 2:
    #     return "E"

    # if localposition[0] < 0:
    #     return "E"
    
    # if localposition[0] > maxRow:
    #     return "E"
    
    # if localposition[1] < 0:
    #     return "E"
    
    # if localposition[1] > maxCol:
    #     return "E"
    
    #print(len(lines))
    #print(len(lines[0]))
    #print(localposition[0])
    #print(localposition[1])
    return lines[localposition[0]][localposition[1]]

def addDirectionToPosition(localposition,direction):
    #if len(localposition) != 2:
    #    return "E"
    #if len(direction) != 2:
    #    return "E"
    
    newposition = [localposition[0]+direction[0],localposition[1]+direction[1]]
    #print("newposition",newposition)
    if getCharFromPosition(newposition,lines) != "E":
        return newposition
    else:
        return localposition

def getCharacterPositions(regex):
    allXPositions = []
    for indexRow,line in enumerate(lines):
        #line = line.rstrip()
        #print(line)
        indicesOfX = re.finditer(regex,line)
        indicesOfX = [ind.start() for ind in indicesOfX]
        for index in indicesOfX:
            #print(index)
            allXPositions.append([indexRow,index])
        output = ""
        for indexCol,char in enumerate(line):
            #print("char",char)
            #print("indexChar",indexChar)
            if indexCol in indicesOfX:
                output += regex
            else:
                output += "."

        print(indexRow,output)
    return allXPositions

def part_one(allXPositions):
    #print(allXPositions)
    #directions = [[1,0],[1,1],[1,-1]]
    directions = []
    chars = ['X','M','A','S','']
    for rowOffset in range(-1,2,1):
        for colOffset in range(-1,2,1):
            directions.append([rowOffset,colOffset])
    #print(directions)
    xmasFound = 0
    for position in allXPositions:
        #print("")
        #print("position: ",position)
        #print("")
        for direction in directions:
            charsFound = 0
            found = False
            positionToCheck = position
            #print("checking direction: ",direction)
            charAtPosition = getCharFromPosition(positionToCheck,lines)
            #print("char at position",charAtPosition)
            while  charAtPosition == chars[charsFound] and not found:
                #print("charsFound ",charsFound)
                positionToCheck = addDirectionToPosition(positionToCheck,direction)
                #print("newposition",positionToCheck)
                charAtPosition = getCharFromPosition(positionToCheck,lines)
                #print("char at position",charAtPosition)
                charsFound += 1
                if charsFound == len(chars)-1:
                    #print("found XMAS in direction",direction)
                    xmasFound += 1
                    found = True
    return xmasFound

def getSurroundingCharacters(position):
    if len(position) != 2:
        return False
    
    row = position[0]
    col = position[1]
    #0 1 2 3

    #a-b
    #-A-
    #c-d
    a = lines[row-1][col-1]
    b = lines[row-1][col+1]
    c = lines[row+1][col-1]
    d = lines[row+1][col+1]

    diag1= []
    diag1.append(a)
    diag1.append(d)
    diag1.sort()
    diag2= []
    diag2.append(c)
    diag2.append(b)
    diag2.sort()
    #print([a,b],[c,d])
    #print(diag1)
    #print(diag2)
    if diag1 == ["M","S"] and diag2 == ["M","S"]:
        return True


    return False

def visual_part_two(positions):
    for indexRow,line in enumerate(lines):
        output = ""
        for indexCol,char in enumerate(line):
            found = False
            for position in positions:
                if(indexCol == position[1]) and (indexRow == position[0]) and not found:
                    output += "A"
                    found = True
            if not found:
                output += "."
        print(output)

def part_two(positions):
    sum = 0
    validPositions = []
    for position in positions:
        #print("")
        #print("")
        #print("new position: ",position)
        getSurroundingCharacters(position)
        if getSurroundingCharacters(position) == True:
            validPositions.append(position)
            sum +=1
    return sum,validPositions

x_positions = getCharacterPositions(r"X")
solution_one = part_one(x_positions)

print("Solution Part one:" ,solution_one)


a_positions = getCharacterPositions(r"A")
solution_two,pos = part_two(a_positions)

visual_part_two(pos)

print("Solution Part two:" ,solution_two)
