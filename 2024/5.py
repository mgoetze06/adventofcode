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

print(rules)
print(updates)

def getRulesBeginningWithNumber(number):
    rulesWithNumber = [x for x in rules if x[0] == number]
    return rulesWithNumber

def part_one(updates,rules):
    sum = 0
    for update in updates:
        print("update: ",update)
        updateInOrder = True

        for index,number in enumerate(update):
            rules = getRulesBeginningWithNumber(number)
            print(rules)
            for rule in rules:
                print("rule: ",rule)
                if rule[1] in update:
                    if update.index(rule[1]) < update.index(rule[0]):
                        updateInOrder = False
                        print("updateNotInOrder")

        if updateInOrder:
            sum += int(update[len(update)//2])
            validUpdates.append(update)

    print(validUpdates)
    return sum

def part_two():
    return ""




solution_one = part_one(updates,rules)
print("Solution Part one:" ,solution_one)
solution_two = part_two()
print("Solution Part two:" ,solution_two)