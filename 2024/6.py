import re
with open('./input/6_val.txt') as f:
    lines = f.readlines()
print("total rows: ",len(lines))
#print(lines[0])
lines = [l.strip() for l in lines]
#lines = "".join(lines)
print(lines)
def getPlayerPosition():
    
    return [[],[]]


def getCharFromPosition(localposition,lines):
    maxRow = len(lines)-1
    maxCol = len(lines[0])-1
    
    if len(localposition) != 2:
        return "E"

    if localposition[0] < 0:
        return "E"
    
    if localposition[0] > maxRow:
        return "E"
    
    if localposition[1] < 0:
        return "E"
    
    if localposition[1] > maxCol:
        return "E"
    
    return lines[localposition[0]][localposition[1]]

def addDirectionToPosition(localposition,direction):
    if len(localposition) != 2:
        return "E"
    if len(direction) != 2:
        return "E"
    
    newposition = [localposition[0]+direction[0],localposition[1]+direction[1]]
    #print("newposition",newposition)
    if getCharFromPosition(newposition,lines) != "E":
        return newposition
    else:
        return localposition
    
def rotate(direction):
    if direction == [-1,0]:
        direction = [0,1]
        sign = ">"
    else:
        if direction == [0,1]:
            direction = [1,0]
            sign = "v"
        else:
            if direction == [1,0]:
                direction = [0,-1]
                sign = "<"
            else:
                if direction == [0,-1]:
                    direction = [-1,0]
                    sign = "^"
    return direction,sign
allXPositions = []

playerInitDirection = [-1,0]
for indexRow,line in enumerate(lines):
    print(line)
    col = re.finditer(r"\^",line)
    col = [ind.start() for ind in col]
    #print(col)
    if col:
        #print("row",indexRow)
        #print("col",col[0])
        print("found Player")
        playerPosition = [indexRow,col[0]]
        print(playerPosition)
        break

currentDirection = playerInitDirection
currentPlayerSign = "^"
while(playerPosition[0] > 0):
    nextChar = getCharFromPosition(addDirectionToPosition(playerPosition,currentDirection),lines)
    print(nextChar)

    if (nextChar != ".") and (nextChar != "X"):
        currentDirection,currentPlayerSign = rotate(currentDirection)
    else:
        print("update old player position to .")
        #lines[playerPosition[0]][playerPosition[1]] = "."
    playerPosition = addDirectionToPosition(playerPosition,currentDirection)
    print(playerPosition)
    #lines[playerPosition[0]][playerPosition[1]] = currentPlayerSign
    print("update new player position to ",currentPlayerSign)



            