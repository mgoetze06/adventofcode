import re
with open('51_val.txt') as f:
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


class Rule:
    def __init__(self, destinationRange, sourceRange, rangeLength):
        self.destinationRange = destinationRange
        self.sourceRange = sourceRange
        self.rangeLength = rangeLength
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
            if len(line_split) > 1:
                d = line_split[0]
                s = line_split[1]
                l = line_split[2]
                r = Rule(d,s,l)
                rules.append(r)

    

      
#map_rows = [row for row in lines if "map" in row]
#print(map_rows)
# 
# 
for m in maps:
    print(m.print())
    for rule in m.rules:
        rule.print()