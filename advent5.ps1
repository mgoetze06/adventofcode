$input = Get-Content "input5.txt"
$length = ($input | Measure-Object).count
#[convert]::ToString(63,2)

#[convert]::ToInt32('1000000',2)
newfunction
for($i = 0; $i -lt $length; $i++){
    $x1 = $input[$i].Substring(0,1)
    $y1 = $input[$i].Substring(1,1)
    $x2 = $input[$i].Substring(7,1)
    $y2 = $input[$i].Substring(8,1)

    Write-output "$x1 $y1 $x2 $y2"
} 


