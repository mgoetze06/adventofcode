import re


with open('3.txt') as f:
    lines = f.readlines()
print("total rows: ",len(lines))
print(lines[0])

lines = "".join(lines)

patterns = re.findall("mul\(\d*,\d*\)", lines)
print(dir(patterns))
print(patterns)

sum = 0

for pattern in patterns:
    print(pattern)
    first = int(pattern.split(",")[0].split("mul(")[1])
    print(first)
    last = int(pattern.split(",")[1].split(")")[0])
    print(last)

    mul = first*last
    sum += mul

print(sum)