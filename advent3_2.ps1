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

$input = Get-Content "input4.txt"
$length = ($input | Measure-Object).count
#$input[0].Substring(0,1)
$columns =  $input[0].Length
#$columns
#$list = [System.Collections.ArrayList]@()

$oxy = ""
$co = ""
#[convert]::ToString(63,2)
#[convert]::ToInt32('1000000',2)


######oxy calculation
for($j = 0; $j -lt $columns; $j++){
    $zeros = 0
    $ones = 0
    if($j -eq 0){
        $length = ($input | Measure-Object).count - 1
    }else{
        $length = ($input | Measure-Object).count
    }
    Write-Output " "
    Write-Output " "
    Write-Output "Elements: $length" 
    
    if($length -eq 1){
        $oxy = $input
        break
    }

    Write-Output "Column: $j" 
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
    Write-Output "Zeroslist, zeros: $zeros" 
    $zeroslist
    Write-Output "Oneslist, ones: $ones"
    $oneslist
    #clear-variable $input
    if(($ones -gt $zeros)-or($ones -eq $zeros)){
        $input = $oneslist
        $oxy += '1'
        #$co += '0'
        Write-Output "Common Bit: 1"
    }else{
        $input = $zeroslist
        $oxy += '0'
        #$co += '1'
        Write-Output "Common Bit: 0"
    }
    $ones = 0
    $zeros = 0
    # clear-variable $oneslist $zeroslist -ErrorAction SilentlyContinue
}
    Write-Output " "
    Write-Output " "
    Write-Output "#####################CO Calculation################"
    Write-Output " "
######co calculation
$input = Get-Content "input4.txt"
$length = ($input | Measure-Object).count
#$input[0].Substring(0,1)
$columns =  $input[0].Length
for($j = 0; $j -lt $columns; $j++){
    $zeros = 0
    $ones = 0
    if($j -eq 0){
        $length = ($input | Measure-Object).count
    }else{
        $length = ($input | Measure-Object).count
    }
    Write-Output " "
    Write-Output " "
    Write-Output "Elements: $length" 
    
    if($length -eq 1){
        $co = $input
        break
    }

    Write-Output "Column: $j" 
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
    Write-Output "Zeroslist, zeros: $zeros" 
    $zeroslist
    Write-Output "Oneslist, ones: $ones"
    $oneslist
    #clear-variable $input
    if(($zeros -lt $ones)-or($ones -eq $zeros)){
        $input = $zeroslist
        #$oxy += '1'
        $co += '0'
        Write-Output "Common Bit: 0"
    }else{
        $input = $oneslist
        #$oxy += '0'
        $co += '1'
        Write-Output "Common Bit: 1"
    }
    Write-Output "CO: $co"
    $ones = 0
    $zeros = 0
    # clear-variable $oneslist $zeroslist -ErrorAction SilentlyContinue
}
Write-Output "oxy: $oxy"
Write-Output "co: $co"
$oxy_int = [convert]::ToInt32($oxy,2)
$co_int = [convert]::ToInt32($co,2)
$oxy_int
$co_int

$oxy_int * $co_int