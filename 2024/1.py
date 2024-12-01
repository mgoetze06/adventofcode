with open('11.txt') as f:
    lines = f.read().splitlines()
print("total rows: ",len(lines))
list1 = []
list2 = []
for row,line in enumerate(lines):
    l1 = line.split("   ")[0]
    l2 = line.split("   ")[1]
    list1.append(int(l1))
    list2.append(int(l2))
list1.sort()
list2.sort()
dist = 0
for i,elem in enumerate(list1):
    count = list2.count(elem)
    dist += abs(list1[i] * count)
print("distance: ",dist)