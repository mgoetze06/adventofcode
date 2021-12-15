$input = Get-Content "input4.txt"
$length = ($input | Measure-Object).count
#$input[0].Substring(0,1)
$columns =  $input[0].Length
$columns
$gamma = ""
$epsilon = ""
$list = [System.Collections.ArrayList]@()
#[convert]::ToString(63,2)
#[convert]::ToInt32('1000000',2)
for($j = 0; $j -lt $columns; $j++){
    $zeros = 0
    $ones = 0
    for($i = 0; $i -lt $length; $i++
        $bit = $input[$i].Substring($j,1)
        if($bit -eq "0"){
            $zeros += 1
        }
        if($bit -eq "1"){
            $ones += 1
        }
 
} 
Write-output "This is gamma "$gamma
$gamma_int = [convert]::ToInt32($gamma,2)
$gamma_int
$epsilon
$epsilon_int = [convert]::ToInt32($epsilon,2)
$epsilon_int

$gamma_int * $epsilon_int



function CommonBitIsTrue(){
    param($list,$column)
    $zeros = 0
    $ones = 0
    $length = ($list | Measure-Object).count
    $returnlist = [System.Collections.ArrayList]@()
    for($i = 0; $i -lt $length; $i++){
        $bit = $input[$i].Substring($j,1)
        if($bit -eq "0"){
            $zeros += 1
        }
        if($bit -eq "1"){
            $ones += 1
        }
    }
    if($ones -gt $zeros){
        $output = $true 
    }
    return $output
}


#0
#1
#0
#1
#1
#1
#1
#1
#0
#0