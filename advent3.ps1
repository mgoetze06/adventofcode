$input = Get-Content "input3.txt"
$length = ($input | Measure-Object).count
$depth = 0
$horizontal = 0
$aim = 0
for($i = 0; $i -lt $length; $i++){
    if($input[$i].Contains("up")){
        #Write-Host "Going up"
        $aim = $aim - [int]$input[$i].Substring(3,1)
    }
    if($input[$i].Contains("forward")){
        #Write-Host "Going forward"
        $horizontal = $horizontal + [int]$input[$i].Substring(8,1)
        $depth = $depth + ($aim * [int]$input[$i].Substring(8,1))
    }
    if($input[$i].Contains("down")){
        #Write-Host "Going down"
        $aim = $aim + [int]$input[$i].Substring(5,1)
    }

} 
$depth
$horizontal
$result = $depth*$horizontal
$result