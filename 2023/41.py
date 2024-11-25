def getCardID(cardstring):
    cardid = int(cardstring.split("Card ")[1].strip())
    return cardid


def splitNumbers(listOfNumbers):
    numberArray = listOfNumbers.strip().split(" ")
    numberArray = [int(x) for x in numberArray if x]
    return numberArray


with open('41.txt') as f:
    lines = f.read().splitlines()

print("total rows: ",len(lines))
print("total cols: ",len(lines[0]))
total_score = 0 
instances_of_cards = dict()

for i in range(len(lines)):
    instances_of_cards.update({i:1})

for row,line in enumerate(lines):
    #print(line)
    
    numberString = line.split(": ")[1]
    cardString = line.split(": ")[0]
    cardID = getCardID(cardString)


    line_split = numberString.split(" | ")
    winning_numbers = splitNumbers(line_split[0])
    numbers = splitNumbers(line_split[1])

    print("card id: ", cardID)
    print("row: ",row)
    #print("winning numbers: ", winning_numbers)
    #print("my numbers: ", numbers)

    total_matching_numbers_per_card = 0
    for winning_number in winning_numbers:
        if winning_number in numbers:
            total_matching_numbers_per_card += 1
    #print("totalWinnersPerCard",total_matching_numbers_per_card)
    for i in range(1,total_matching_numbers_per_card + 1):
        #print(i)
        calculatedCardID = row + i
        #print("calculated row ID Winner: ",calculatedCardID)

        currentWinnerPerCard = instances_of_cards.get(row)
        currentWinnerCalculatedCardID = instances_of_cards.get(calculatedCardID)

        instances_of_cards.update({calculatedCardID:currentWinnerPerCard+currentWinnerCalculatedCardID})
        #print(instances_of_cards)
total = 0
print(instances_of_cards)
for value in instances_of_cards.values():
    #print(value)
    total += value

print(total)