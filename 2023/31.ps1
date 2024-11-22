function tryParse{
    param($stringNumber,$error_return_string)
    $intNumber = 0
    if ([int]::TryParse($stringNumber, [ref]$intNumber)) {
        return $intNumber
    }
    else{
        if ($error_return_string -eq $null){
            $error_return_string = "error"
        }
        return $error_return_string
    }
}


function isSymbol{
    param($char)
    $isSymbol = $true
    if($char -eq "."){
        $isSymbol = $false
    }
    $isDigit = isDigit -char $char | select -last 1
    if($isDigit){
        $isSymbol = $false
    }
    $isSymbol
}
function isDigit{
    param($char)
    $isDigit = $false
    if($char -eq "1" -or $char -eq "2" -or $char -eq "3" -or $char -eq "4" -or $char -eq "5" -or $char -eq "6" -or $char -eq "7" -or $char -eq "8" -or $char -eq "9" -or $char -eq "0"){
        $isDigit = $true
    }
    $isDigit
}

function getStartingDigitPositions{
    param($symbolposition, $data)

    $output = @()


    #Write-HOst "Symbolposition: $symbolposition"
    $row = tryParse -stringnumber $symbolposition[0] -error_return_string "err" | select -last 1
    $col = tryParse -stringnumber $symbolposition[1] -error_return_string "err" | select -last 1
    #Write-Host "Zeile $row; Spalte $col"

    for($rowOffset = -1; $rowOffset -lt 2; $rowOffset++){
        for($colOffset = -1; $colOffset -lt 2; $colOffset++){
            if(!($colOffset -eq 0 -and $rowOffset -eq 0)){

                $row_check = $row + $rowOffset
                $col_check = $col + $colOffset
                #Write-Host "checking position: row: $row_check col: $col_check "

                $digit = isDigit -char $data[$row_check][$col_check]
                if($digit -eq $true){
                    $output += ,($row_check,$col_check)
                    Write-Host "digit found in: row: $row_check col: $col_check "

                }
            }

        }

    }
    $output
}

$symbols = @()

$file = "31_val.txt"
$input = Get-Content $file
$length = ($input | Measure-Object).count
Write-Host "input length $length in file $file"
for($i = 0; $i -lt $length; $i++){
    $input[$i]
    $rowLength = $input[$i].Length
    for($j = 0; $j -lt $rowLength; $j++){
        $isSymbol = isSymbol -char $input[$i][$j] | select -last 1
        if($isSymbol){
            $symbols += ,($i,$j)
        }
    }
} 
Write-HOst $symbols
$first = $symbols[0]
Write-HOst "Symbols index 0: $first"
$first = $symbols[0][0]
Write-HOst "Symbols index 00: $first"
$first = $symbols[0][1]
Write-HOst "Symbols index 01: $first"


$startingDigitPositions = @()

for($i = 0; $i -lt $symbols.Length; $i++){
    $s = $symbols[$i]
    #Write-HOst "Symbols index $i : $s"
    [array]$arr = getStartingDigitPositions -symbolposition $s -data $input
    $positionsToCheck += ,($s,$arr)
} 
for($i = 0; $i -lt $positionsToCheck.Length; $i++){
    $s = $positionsToCheck[$i]
    Write-HOst "Digit Positions index $i : $s"
} 