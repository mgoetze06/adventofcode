with open('51_val.txt') as f:
    lines = f.read().splitlines()

print("total rows: ",len(lines))
print("total cols: ",len(lines[0]))
total_score = 0 


seeds = lines[0].split("seeds: ")[1].split(" ")
seeds = [int(x) for x in seeds]
print(seeds)
