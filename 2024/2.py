with open('2.txt') as f:
    lines = f.read().splitlines()
print("total rows: ",len(lines))

validReports = 0
for row,line in enumerate(lines):
    l1 = line.split(" ")
    allIncreasing = False
    allDecreasing = False
    valid = False

    for level,integer in enumerate(l1):
        if level > 0:
            dist = int(l1[level])-int(l1[level-1])

            if abs(dist) > 3 and abs(dist) < 1:
                #invalid increase
                print("invalid level change")
                valid = False

            if level == 1:
                if dist > 0:
                    allIncreasing = True
                    valid = True

                if dist < 0:
                    allDecreasing = True
                    valid = True

            if level > 1:
                if dist < 0 and allDecreasing == True:
                    print("valid decrease")
                    valid = True

                if dist > 0 and allIncreasing == True:
                    print("valid increase")
                    valid = True

            if valid:
                validReports += 1

                    


    exit