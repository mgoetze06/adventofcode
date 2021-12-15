function Get-CommonBitIsTrue{
    param($list,$column)
    $thislist = $list
    $thiscolumn = $column
    $zeros = 0
    $ones = 0
    $length = ($thislist | Measure-Object).count
    $oneslist = [System.Collections.ArrayList]@()
    $zeroslist = [System.Collections.ArrayList]@()
    for($i = 0; $i -lt $length; $i++){
        #$thislist[0]
        #$thislist[1]
        #$thislist
        $thislist[$i]
        $bit = $thislist[$i].Substring($thiscolumn,1)
        $bit
        if($bit -eq "0"){
            $zeros += 1
            $zeroslist += $i
        }
        if($bit -eq "1"){
            $ones += 1
            $oneslist += $i
        }
    }
    if($ones -gt $zeros){
        $true
        #$oneslist
    }else{
        $false
        #$oneslist
    }
    
}

$input = Get-Content "input4_test.txt"
$length = ($input | Measure-Object).count
#$input[0].Substring(0,1)
$columns =  $input[0].Length
#$columns
#$list = [System.Collections.ArrayList]@()

$oxy = ""
$co = ""
#[convert]::ToString(63,2)
#[convert]::ToInt32('1000000',2)
for($j = 0; $j -lt $columns; $j++){
    $zeros = 0
    $ones = 0
    $length = ($input | Measure-Object).count
    if($length -eq 1){
        break
    }
    Write-Output "Column: " $j
    $oneslist = [System.Collections.ArrayList]@()
    $zeroslist = [System.Collections.ArrayList]@()
    for($i = 0; $i -lt $length; $i++){
        $bit = $input[$i].Substring($j,1)
        if($bit -eq "0"){
            $zeros += 1
            $zeroslist += $input[$i]
        }
        if($bit -eq "1"){
            $ones += 1
            $oneslist += $input[$i]
        }
    }
    $zeroslist
    $oneslist
    #clear-variable $input
    if(($ones -gt $zeros)-or($ones -eq $zeros)){
        $input = $oneslist
        $oxy += '1'
        $co += '0'
        Write-Output "Common Bit: 1"
    }else{
        $input = $zeroslist
        $oxy += '0'
        $co += '1'
        Write-Output "Common Bit: 0"
    }
    # clear-variable $oneslist $zeroslist -ErrorAction SilentlyContinue
}
$oxy
$co
#$gamma_int = [convert]::ToInt32($gamma,2)
#$epsilon_int = [convert]::ToInt32($epsilon,2)







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