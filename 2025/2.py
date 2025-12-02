from utils_2025 import *
debug = False

with open('input\\2.txt') as f:
    lines = f.read()
print("total rows: ",len(lines))
allIDs = lines.split(",")


def firstPartOfPuzzle(allIDs):
    invalidId = 0
    for row,line in enumerate(allIDs):
        id_start = int(line.split("-")[0])
        id_end = int(line.split("-")[1])
        printDebug(str(id_start)+" bis "+ str(id_end),debug)
        for id in range(id_start,id_end+1,1):
            string = str(id)
            firstpart, secondpart = string[:len(string)//2], string[len(string)//2:]
            printDebug("first: " + firstpart + " second: " + secondpart,debug)
            if firstpart == secondpart:
                invalidId += id
                printDebug(str(invalidId)+" invalid IDs",debug)
    print(invalidId)

def secondPartOfPuzzle(allIDs):
    invalidId = 0
    for row,line in enumerate(allIDs):
        id_start = int(line.split("-")[0])
        id_end = int(line.split("-")[1])
        printDebug(str(id_start)+" bis "+ str(id_end),debug)
        for id in range(id_start,id_end+1,1):
            string = str(id)
            printDebug(string,debug)
            printDebug(len(string)//2,debug)
            for n in range(1,(len(string)//2)+1,1):
                parts = [string[i:i+n] for i in range(0, len(string), n)]
                printDebug(parts,debug)
                if parts.count(parts[0])==len(parts):
                    printDebug("invalid ID found",debug)
                    invalidId += id
                    break
    print(invalidId)



firstPartOfPuzzle(allIDs=allIDs)
secondPartOfPuzzle(allIDs=allIDs)