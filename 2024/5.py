with open('./input/5.txt') as f:
    lines = f.readlines()
print("total rows: ",len(lines))
#print(lines[0])

rules = []
updates = []
validUpdates = []
for line in lines:
    line = line.strip()
    if "|" in line:
        rule = [int(x) for x in line.split("|")]
        rules.append(rule)

    if "," in line:
        update = [int(x) for x in line.split(",")]
        updates.append(update)

#print(rules)
#print(updates)

def getRulesBeginningWithNumber(number):
    rulesWithNumber = [x for x in rules if x[0] == number]
    return rulesWithNumber

def part_one(updates,rules):
    sum = 0
    for update in updates:
        #print("update: ",update)
        updateInOrder = True

        for index,number in enumerate(update):
            rules = getRulesBeginningWithNumber(number)
            #print(rules)
            for rule in rules:
                #print("rule: ",rule)
                if rule[1] in update:
                    if update.index(rule[1]) < update.index(rule[0]):
                        updateInOrder = False
                        #print("updateNotInOrder")

        if updateInOrder:
            sum += int(update[len(update)//2])
            validUpdates.append(update)

    #print(validUpdates)
    return sum

def switchValuesAtPositions(update,pos1,pos2):
    oldvalue1 = update[pos1]
    oldvalue2 = update[pos2]

    update[pos1] = oldvalue2
    update[pos2] = oldvalue1
    return update


def part_two(updates,rules):
    sum = 0
    for update in updates:
        #print("update: ",update)
        updateInOrder = True
        anyBrokenRule = True
        while(anyBrokenRule):
            thisUpdateChanged = False
            for index,number in enumerate(update):
                rules = getRulesBeginningWithNumber(number)
                #print(rules)

                
                for rule in rules:
                    #print("rule: ",rule)
                    if rule[1] in update:
                        if update.index(rule[1]) < update.index(rule[0]):
                            #print("update before changing",update)
                            #print("update.index(rule[1])",update.index(rule[1]))
                            #print("update before changing at index",update[update.index(rule[1])])
                            #print("update.index(rule[0])",update.index(rule[0]))
                            #print("update before changing at index",update[update.index(rule[0])])


                            update = switchValuesAtPositions(update,update.index(rule[1]),update.index(rule[0]))
                            updateInOrder = False
                            thisUpdateChanged = True
                            anyBrokenRule = True
                            #print("updateNotInOrder")
                            #print(update)
                            #exit()
                        
                if not thisUpdateChanged:
                    anyBrokenRule = False
                #print()
        #print("update valid, not adding")

        if not updateInOrder:
            print(update)
            sum += int(update[len(update)//2])
            validUpdates.append(update)

    #print(validUpdates)
    return sum




solution_one = part_one(updates,rules)
print("Solution Part one:" ,solution_one)
solution_two = part_two(updates,rules)
print("Solution Part two:" ,solution_two)