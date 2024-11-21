$input = Get-Content "input.txt"
$length = ($input | Measure-Object).count
$increasing = 0
$sum = 0
$nextsum = 0
for($i = 0; $i -lt $length; $i++){
    if(($i -gt 0)-And($i -lt ($length-2))){
        $sum = [int]$input[$i] + [int]$input[$i-1]+[int]$input[$i+1]
        $nextsum = [int]$input[$i] + [int]$input[$i+1]+[int]$input[$i+2]
        if($nextsum -gt $sum){
            #$input[$i-1]
            $increasing = $increasing + 1
            #Write-Host "Increasing"
            #$input[$i]
        }
    }
} 
$increasing
