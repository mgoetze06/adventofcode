import re


with open('3.txt') as f:
    lines = f.readlines()
print("total rows: ",len(lines))
print(lines[0])

lines = "".join(lines)

patterns = re.findall("mul\(\d*,\d*\)", lines)
indicesOfpatterns = re.finditer("mul\(\d*,\d*\)", lines)
indicesOfpatterns = [ind.start() for ind in indicesOfpatterns]
print(dir(patterns))
print(patterns)
print(patterns.index)


print("finding start do()")
dos = re.finditer(r"do\(\)", lines)
print(dos)
do_start = [ind.start() for ind in dos]
do_start.append(0)
do_start.sort()

#print("finding end don't()")
donts = re.finditer(r"don't\(\)", lines)
print(donts)
dont_start = [ind.start() for ind in donts]

allowedRanges = []
print(do_start)
print(dont_start)
lastRangeEnd = -1
for i in range(len(do_start)):
    range_start = do_start[i]
    if lastRangeEnd < range_start:
        first_start = range_start
        if i > len(dont_start)-1:
            range_end = len(lines)
        else:
            range_end = dont_start[i]


        # if i != len(do_start)-1:
        #     if range_end > do_start[i+1]:
        #         range_start = do_start[i+1]
        # if i != len(do_start)-1:
        #     temp = i+1
        temp = i
        nextStart = do_start[i]

        while range_end > nextStart:
            range_start = nextStart
            temp = temp + 1
            if temp < len(do_start):
                nextStart = do_start[temp]
            else:
                range_start = first_start
                break

        # print("after first while")
        # print("range start ",range_start)
        # print("range end",range_end)
        while range_end < range_start:
            temp = temp + 1
            if temp < len(dont_start):
                range_end = dont_start[temp]
            else:
                range_end = len(lines)
                break
            # print("after seconde while")
            # print("range start ",range_start)
            # print("range end",range_end)



        if range_end>range_start:
            allowedRanges.append([range_start,range_end])
            lastRangeEnd = range_end

print(allowedRanges)


sum = 0

for pattern,index in zip(patterns,indicesOfpatterns):
    allowed = False
    for allowedRange in allowedRanges:
        if allowedRange[0] < index < allowedRange[1]:
            allowed = True
            break
    
    if allowed:
        print(pattern)
        first = int(pattern.split(",")[0].split("mul(")[1])
        print(first)
        last = int(pattern.split(",")[1].split(")")[0])
        print(last)

        mul = first*last
        sum += mul

print(sum)