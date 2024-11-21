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

$input = Get-Content "11.txt"
$length = ($input | Measure-Object).count
$length

$firstDigitString = ""
$lastDigitString = ""
$lastDigit = 0
$firstDigitFound = $false
$calibration_values = 0
for($i = 0; $i -lt $length; $i++){
    $replacedInput = replaceSpelledDigits -word $input[$i] | select -last 1
    $linelength = $replacedInput.Length
    $replacedInput
    #$linelength
    for($j = 0; $j -lt $linelength; $j++){        
        $parsedValue = tryParse -stringNumber $replacedInput[$j] -error_return_string "err" | select -last 1
        if($parsedValue -ne "err"){
            #$parsedValue
            if($firstDigitFound -eq $false){
                $firstDigitString = $replacedInput[$j]
                $firstDigitFound = $true
            }
            $lastDigitString = $replacedInput[$j]
        }
    }
    #Write-Host "First Digit: $firstDigitString Last Digit: $lastDigitString"
    $calibration_value = $firstDigitString + $lastDigitString
    $calibration_value = tryParse -stringNumber $calibration_value -error_return_string "err" | select -last 1
    #Write-Host $calibration_value
    $calibration_values = $calibration_values + $calibration_value
    $firstDigitFound = $false
    # if($i -eq 0){
    #     exit
    # }
} 
$calibration_values


