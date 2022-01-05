$input = Get-Content "input6.txt"
$fish = [System.Collections.ArrayList]@()
$fish = $input.Split(",")
#$fish -join ""
#                 (0,1,2,3,4,5,6,7,8)
$fish_counters = @(0,0,0,0,0,0,0,0,0)
$new_fish_counters = @(0,0,0,0,0,0,0,0,0)

for($f = 0; $f -lt ($fish | Measure-Object).count; $f++){
    $fish_counters[$fish[$f]] += 1 
}
    
    #add the amount of zeros as eigths to the array
    #for($n = 0; $n -lt $newFish; $n++){
    #    $fish += 8
    #}
    #Write-Output "Iteration: $i"
    #($fish | Measure-Object).count
    #$fish -join ""
$fish_counters

for($i = 0; $i -lt 256; $i++){
    Write-Output "Iteration: $i"   
    for($j = 0; $j -lt (($fish_counters | Measure-Object).count - 1); $j++){
       $new_fish_counters[$j] = $fish_counters[$j+1] 
     
    }
       $new_fish_counters[8] = $fish_counters[0]
       $new_fish_counters[6] = $new_fish_counters[6] + $fish_counters[0]

       $fish_counters = $new_fish_counters
       $new_fish_counters = @(0,0,0,0,0,0,0,0,0)
       #$fish_counters
}
$total = 0
for($j = 0; $j -lt ($fish_counters | Measure-Object).count; $j++){
    $total += $fish_counters[$j]
}
$fish_counters
$total
#$fish_counters