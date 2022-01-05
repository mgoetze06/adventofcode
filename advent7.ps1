$input = Get-Content "input7.txt"
$crabs = [System.Collections.ArrayList]@()
$crabs = $input.Split(",")
#$crabs
$crab_count = ($crabs | Measure-Object).count

for($i = 0; $i -lt 1000; $i++){ #loop over each position
    Write-Output "Iteration: $i" 
    $total_fuel = 0
    for($j = 0; $j -lt $crab_count; $j++){
        $steps = [math]::Abs($crabs[$j] - $i)
        $fuel_consumption = 0
        for($s = 1; $s -lt $steps; $s++){
            $fuel_consumption += $s
        }
        $total_fuel += $fuel_consumption
    }
    if($i -eq 0){
        $min_fuel = $total_fuel
    }else{
        if($total_fuel -lt $min_fuel){
            $min_fuel = $total_fuel
            $ideal_position = $i
        }
    }
    $min_fuel
}
$min_fuel
$ideal_position