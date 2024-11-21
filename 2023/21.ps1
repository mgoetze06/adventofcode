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

function replaceStringWithInt{
    param($word)
    $digits = @("one","two","three","four","five","six","seven","eight","nine")
    $digitsToReplace = @("o1e","t2o","th3ee","f4ur","f5ve","s6x","se7en","ei8ht","n9e")

    for($i = 0; $i -lt $digits.length; $i++){
        $word = $word -replace($digits[$i],$digitsToReplace[$i])
    }
    $word
}

function replaceSpelledDigits{
    param($word)
    $linelength = $word.Length
    #Write-Host $word
    #Write-Host $linelength
    $endIndex = 0
    $startIndex = 0
    $subStringLength = 1
    $output = ""
    while($endIndex -ne $linelength){
        $linelength = $word.Length
        $endIndex = $startIndex + $subStringLength

        $stringToCheck = $word.substring($startIndex,$subStringLength)
        $restOfWord = $word.substring($startIndex + $subStringLength)
       # Write-Host "string before check: $stringToCheck"
        $afterReplace = replaceStringWithInt -word $stringToCheck | select -last 1
        #Write-Host "string after check: $afterReplace"
        $subStringLength += 1

        if($afterReplace -ne $stringToCheck){
            $output = $afterReplace + $restOfWord
           # Write-Host "new output: $output"
            $word = $output
            $subStringLength = 0
        }

        #$word = $stringToCheck
    }
    $word
}


function get-gameid{
    param($gamestring)

    $gameid = $gamestring.substring(4)
    $gameid = tryParse -stringNumber $gameid | select -last 1

    $gameid

}
function get-colorCount{
    param($colorstring)
    $number = $colorstring.Split(" ")[0]
    $intNumber = tryParse -stringNumber $number -error_return_string "err"
    $intNumber
}
function get-colorCode{
    param($colorstring)
    $code = $colorstring.Split(" ")[1].Trim()
    $code
}

$input = Get-Content "21.txt"
$length = ($input | Measure-Object).count
$length


$bagAmountRed = 12
$bagAmountGreen = 13
$bagAmountBlue = 14


$redValid = $true
$greenValid = $true
$blueValid = $true



$validGameID = @()
$totalpower = 0
for($i = 0; $i -lt $length; $i++){
    $game = $input[$i]
    $split = $game.Split(":")
    $gamestring = $split[0]
    $gameId = get-gameid -gamestring $gamestring | select -last 1
    Write-Host "Gamestring: $gamestring mit GameID: $gameId"

    $subsets = $split[1].Split(";")
    $subsets
    $redValid = $true
    $greenValid = $true
    $blueValid = $true

    $minimumRed = 0
    $minimumGreen = 0
    $minimumBlue = 0

    for($j = 0; $j -lt $subsets.Count; $j++){
        #$subsets[$j]
        [array]$colors = $subsets[$j].Split(",").Trim()

        #$colors
        for($k = 0; $k -lt $colors.Count; $k++){
            $code = get-colorCode -colorstring $colors[$k]
            $colorCount = get-colorCount -colorstring $colors[$k]
            if($code -contains "red"){
                if($colorCount -gt $bagAmountRed){
                    $redValid = $false
                }
                if($colorCount -ge $minimumRed){
                    $minimumRed = $colorCount
                }
            } 
            if($code -contains "green"){
                if($colorCount -gt $bagAmountGreen){
                    $greenValid = $false
                }
                if($colorCount -ge $minimumGreen){
                    $minimumGreen = $colorCount
                }
            }             
            if($code -contains "blue"){
                if($colorCount -gt $bagAmountBlue){
                    $blueValid = $false
                }
                if($colorCount -ge $minimumBlue){
                    $minimumBlue = $colorCount
                }
            } 







            #Write-Host "Detected Color: $code with $colorCount "
        }
    }
    Write-Host "$minimumBlue $minimumGreen $minimumRed"
    $power = $minimumBlue*$minimumGreen*$minimumRed
    $totalpower += $power
    if($redValid -eq $false -or $greenValid -eq $false -or $blueValid -eq $false){
        Write-Host "Invalid Game"
    }else{
        Write-Host "Valid Game"

        $validGameID += @(($gameId))
    }
    #exit
} 
$validGameID
$sum = 0
for($j = 0; $j -lt $validGameID.Count; $j++){

    $sum += $validGameID[$j]
}
Write-Host "game ID Sum: $sum"

Write-Host "total Power: $totalpower"