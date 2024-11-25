import re
with open('51.txt') as f:
    lines = f.read().splitlines()

print("total rows: ",len(lines))
print("total cols: ",len(lines[0]))
total_score = 0 


seeds = lines[0].split("seeds: ")[1].split(" ")
seeds = [int(x) for x in seeds]
print(seeds)



class TransformationMap:
    def __init__(self, index, rules):
        self.rules = rules
        self.index = index
    def print(self):
        print(f"Map {self.index}({self.rules})")
    

    def runOnPoint(self,point):
        for rule in self.rules:
            #ruleOffset = rule.destinationRange - rule.sourceRange
            newvalue = point
            if rule.sourceRange <= point < (rule.sourceRange + rule.rangeLength):
                newvalue = rule.destinationRange + point - rule.sourceRange
                #print("applied Rule: ",rule.print())
                return newvalue
        return newvalue

class Rule:
    def __init__(self, destinationRange, sourceRange, rangeLength):
        self.destinationRange = int(destinationRange)
        self.sourceRange = int(sourceRange)
        self.rangeLength = int(rangeLength)
    def print(self):
        print(f"Rule {self.destinationRange} {self.sourceRange} {self.rangeLength}")

index = -1
rules = []
maps = []
for line in lines[1:]:
    if "map" in line:
        if index > -1:
           m = TransformationMap(index,rules)
           maps.append(m)
           rules = []
        index += 1
    else:
        if not line == "":
            line_split = line.split(" ")
            if len(line_split) > 2:
                d = line_split[0]
                s = line_split[1]
                l = line_split[2]
                r = Rule(d,s,l)
                rules.append(r)
m = TransformationMap(index,rules)
maps.append(m)
    

      
#map_rows = [row for row in lines if "map" in row]
#print(map_rows)
# 
# 
for m in maps:
    print(m.print())
    for rule in m.rules:
        rule.print()

outputMatrix = [seeds]

for id,map in enumerate(maps):
    newOutput = []
    for i,seed in enumerate(seeds):
        newOutput.append(maps[id].runOnPoint(outputMatrix[id][i]))
    outputMatrix.append(newOutput)

for i,output in enumerate(outputMatrix):
    print(f"id {i}:",output)
print(min(outputMatrix[7]))