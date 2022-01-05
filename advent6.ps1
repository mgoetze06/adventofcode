$input = Get-Content "input6.txt"
$fish = [System.Collections.ArrayList]@()
$fish = $input.Split(",")
#$fish -join ""

for($i = 0; $i -lt 80; $i++){
    $newFish = 0
    for($f = 0; $f -lt ($fish | Measure-Object).count; $f++){
        #count how many 0 there are 
        if($fish[$f] -eq 0){
            $newFish += 1
            $fish[$f] = 6
        }else{
            $fish[$f] -= 1
        }
        #decrease each fish by one
         

    }
    
    #add the amount of zeros as eigths to the array
    for($n = 0; $n -lt $newFish; $n++){
        $fish += 8
    }
    Write-Output "Iteration: $i"
    ($fish | Measure-Object).count
    #$fish -join ""
}