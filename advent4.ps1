$input = Get-Content "input4.txt"
$length = ($input | Measure-Object).count
$input[0].Substring(0,1)

#small changes
[convert]::ToString(63,2)

[convert]::ToInt32('1000000',2)

for($i = 0; $i -lt $length; $i++){

} 
