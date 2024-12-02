with open('2.txt') as f:
    lines = f.read().splitlines()
print("total rows: ",len(lines))



validReports = 0
for row,line in enumerate(lines):
    print(line)
    l2 = line.split(" ")
    positionremoved = 0
    invalidCount = 1

    while(invalidCount != 0 and positionremoved < len(l2)):
        l1 = l2.copy()
        l1.pop(positionremoved)
        print(l1)

        allIncreasing = False
        allDecreasing = False
        valid = True

        validIncrease = 0
        validDecrease = 0
        invalidCount = 0
        for level,integer in enumerate(l1):
            if level > 0:
                #print("Level",level)
                #print("Integer:",integer)
                dist = int(l1[level])-int(l1[level-1])
                #print("changing from",int(l1[level-1]))
                #print("to",int(l1[level]))
                #print("distance: ",dist)
                if abs(dist) > 3 or abs(dist) < 1:
                    #invalid increase
                    #print("invalid level change")
                    valid = False
                    invalidCount += 1

                    #validIncrease = 0
                    #validDecrease = 0
                    #break
                else:
                    #if dist > 0:
                    #    validIncrease += 1
                    #if dist < 0:
                    #    validDecrease += 1

                    if level == 1:
                        if dist > 0:
                            allIncreasing = True
                            valid = True
                            
                            #print("detected inrease")


                        if dist < 0:
                            allDecreasing = True
                            valid = True
                            #print("detected decrease")


                    if level > 1:
                        if dist < 0 and allDecreasing == True:
                            #print("valid decrease")
                            validIncrease += 1
                            valid = True
                        else:

                            if dist > 0 and allIncreasing == True:
                                #print("valid increase")
                                valid = True
                                validDecrease += 1
                            else:
                                valid = False
                                invalidCount += 1
                                #break
        #print("invalidCount",invalidCount)
        if invalidCount > 0:
            positionremoved += 1
            validReport = False
        else:
            validReport = True
        #if (validIncrease > 1 and validDecrease <= 1) or (validIncrease <= 1 and validDecrease > 1) and invalidCount == 0:
            #print("adding validreports")
    if validReport:
        validReports += 1
        #print("validIncrease: ",validIncrease)
        #print("validDecrease: ",validDecrease)


print(validReports)