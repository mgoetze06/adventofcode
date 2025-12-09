from utils_2025 import *
import re


debug = False

with open('input\\7_val.txt') as f:
    lines = f.read().splitlines()
print("total rows: ",len(lines))


def findStartingPoint(line):
    index = []
    index.append(line.index("S"))
    return index

def getNextSplitterPositions(line,oldSplitters):
    splitters = []
    for id,char in enumerate(line):
        if char == "^":
            #if id not in oldSplitters:
            splitters.append(id)
    return splitters

def getNewBeamPositions(splitters):
    beamPositions = []
    for splitter in splitters:
        if int(splitter)+1 not in beamPositions:
            beamPositions.append(int(splitter)+1)
        if int(splitter)-1 not in beamPositions:
            beamPositions.append(int(splitter)-1)
    return beamPositions

def intersectBeamPosition(newSplitterBeams,oldBeams):
    for newSplitterBeam in newSplitterBeams:
        if newSplitterBeam not in oldBeams:
            oldBeams.append(newSplitterBeam)


    return oldBeams

def removeOldBeamsAtSplitters(splitters,beams):
    splitted = 0
    for splitter in splitters:
        if splitter in beams:
            beams.remove(splitter)
            splitted += 1
    return beams,splitted

def day7_part1(lines):
    currentRow = 0
    beamPositions = findStartingPoint(lines[currentRow])
    splitters = []
    total = 0
    while currentRow < len(lines):
        if "^" in lines[currentRow]:
            #print(lines[currentRow])
            splitters = getNextSplitterPositions(lines[currentRow],splitters)
            newBeamsFromSplitters = getNewBeamPositions(splitters)
            #print("newbeams from splitters: ",newBeamsFromSplitters)

            beamPositions,splitted = removeOldBeamsAtSplitters(splitters,beamPositions)
            total += splitted
            #print("newBeams without splitters",beamPositions)
            beamPositions = intersectBeamPosition(newBeamsFromSplitters,beamPositions)
            #print("newbeams: ",beamPositions)
        currentRow += 1
    print(total)

class Node:
    def __init__(self, key, parent):
        self.parent = parent
        self.left = None
        self.right = None
        self.val = key
        print("new node: ",self.val)

    def printNode(self):
        print(self.val)

def findLeft(root,lines):
    print("finding left neigh of",root.val)
    if root.val[0] + 1 >= len(lines):
        return None
    if root.val[1] - 1 < 0:
        return None
    newNodeValueRow = root.val[0] + 1
    while lines[newNodeValueRow][root.val[1]-1] != "^":
        newNodeValueRow += 1
        if newNodeValueRow >= len(lines):
            break
    return Node([newNodeValueRow,root.val[1]-1],root)
def findRight(root,lines):
    print("finding right neigh of",root.val)
    if root.val[0] + 1 >= len(lines):
        return None
    if root.val[1] + 1 >= len(lines[0]):
        return None
    newNodeValueRow = root.val[0] + 1
    while lines[newNodeValueRow][root.val[1]+1] != "^":
        #print(lines[newNodeValueRow])
        newNodeValueRow += 1
        if newNodeValueRow >= len(lines):
            break
    return Node([newNodeValueRow,root.val[1]+1],root)

def DFS(root):
  #depth first search
    global totalPaths
    if root == None:
        totalPaths += 1
        return

    print("Visiting node: ",root.val)
    DFS(root.left)
    DFS(root.right)

def search(root):
    if root == None:
        return
    root.left = findLeft(root,lines)
    search(root.left)
    root.right = findRight(root,lines)
    search(root.right)

def day7_part2(lines):
    currentRow = 0
    global totalPaths
    totalPaths = 0
    startingPoint = findStartingPoint(lines[currentRow])
    globalRoot = Node([0,startingPoint[0]],None)
    search(globalRoot)
    DFS(globalRoot)
    print(totalPaths)
    return

day7_part1(lines)
day7_part2(lines)