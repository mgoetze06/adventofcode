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

function getDigitPositions{
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


function getNumberFromPosition(){
    param($digitposition, $data, $usedPositions)

    $usedPositions = @()

    $row = $digitposition[0]
    $col = $digitposition[1]

    $startrow = $row
    $startcol = $col
    $currentChar = $data[$row][$col]
    Write-Host "Current Digit: $currentChar"
    $output = ""
    $isDigit = isDigit -char $currentChar | select -last 1
    while($isDigit){
        $usedPositions += ,($row,$col)
        $output = $output + $data[$row][$col]
        $col = $col + 1
        $currentChar = $data[$row][$col]
        $isDigit = isDigit -char $currentChar | select -last 1

    }
    
    $col = $startcol - 1
    $currentChar = $data[$row][$col]
    $isDigit = isDigit -char $currentChar | select -last 1
    while($isDigit){
        $usedPositions += ,($row,$col)
        $output = $data[$row][$col]+ $output
        $col = $col - 1
        $currentChar = $data[$row][$col]
        $isDigit = isDigit -char $currentChar | select -last 1

    }

    Write-Warning "Output String: $output"
    $usedPositions
    $output

}

function isNewPosition(){
    param($newpositions,$positions)
    $new = $true
    $length = ($positions | Measure-Object).count

    if($length -eq 0){
        $new = $true
        [array]$positions = $newpositions

        Write-Host $positions
        $positions
        $new

        return
    }
    Write-Host "isNewPosition: $newpositions"
    #Write-Host "Positions: $positions"
    if($newpositions[0].Length -eq 1){
        Write-Host "Length is 0"
        :test for($i = 0; $i -lt $length; $i++){
            if($newpositions[0] -eq $positions[$i][0] -and $newpositions[1] -eq $positions[$i][1]){
                $new = $false
                break :test
            }
            $positions += ,($newpositions[0],$newpositions[1])
        }
    }
    else{
        for($j = 0; $j -lt $newpositions[$i].Length; $j++){
            :test for($i = 0; $i -lt $length; $i++){
                if($newpositions[$j][0] -eq $positions[$i][0] -and $newpositions[$j][1] -eq $positions[$i][1]){
                    $new = $false
                    break :test
                }


            }
            $x = $newpositions[$j][0]
            $y = $newpositions[$j][1]
            Write-Host "New Position $x $y"
            $positions += ,($newpositions[$j][0],$newpositions[$j][1])
        }
    }

    $positions
    $new
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
$allPositions = @()
$numbers = @()
$total = 0

for($i = 0; $i -lt $symbols.Length; $i++){
    $s = $symbols[$i]
    #Write-HOst "Symbols index $i : $s"
    [array]$arr = getDigitPositions -symbolposition $s -data $input
    [array]$positionsToCheck += ,($arr)
} 
for($i = 0; $i -lt $positionsToCheck.Length; $i++){
    $s = $positionsToCheck[$i]
    $numbers = @()
    Write-HOst "Digit Positions index $i"
    if($positionsToCheck[$i][0].Length -eq 1){
        Write-Host "got only one position"
        $result = getNumberFromPosition -digitposition $positionsToCheck[$i] -data $input
        [int]$number = $result | select -last 1
        $usedPositions = $result | select -SkipLast 1
        Write-Host "Number: $number"
        Write-Host "Used Positions: $usedPositions"
        $result = isNewPosition -newposition $usedPositions -positions $allPositions
        [bool]$isNew = $result | select -last 1
        $allPositions = $result | select -SkipLast 1
        if($isNew){
            Write-Host "Found New Number" -ForegroundColor Green

            $total += $number
        }
    }else{
        for($j = 0; $j -lt $positionsToCheck[$i].Length; $j++){
            $position = $positionsToCheck[$i][$j]
            Write-HOst "Position $j : $position"
            $result = getNumberFromPosition -digitposition $position -data $input
            [int]$number = $result | select -last 1
            $usedPositions = $result | select -SkipLast 1
            Write-Host "Number: $number"
            Write-Host "Used Positions: $usedPositions"
            $result = isNewPosition -newposition $usedPositions -positions $allPositions
            [bool]$isNew = $result | select -last 1
            $allPositions = $result | select -SkipLast 1
            if($isNew){
                Write-Host "Found New Number" -ForegroundColor Green
                $total += $number
            }
        }
    }
    


} 
$total