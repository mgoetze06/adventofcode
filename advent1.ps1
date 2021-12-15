$input = Get-Content "input.txt"
$length = ($input | Measure-Object).count
$increasing = 1
for($i = 0; $i -lt $length; $i++){
    if($i -gt 0){
        if($input[$i] -gt $input[$i-1]){
            #$input[$i-1]
            $increasing = $increasing + 1
            #Write-Host "Increasing"
            #$input[$i]
        }
    }
} 
$increasing