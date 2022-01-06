$raw = Get-Content "input8.txt"
$input = [System.Collections.ArrayList]@()
$output = [System.Collections.ArrayList]@()


$length = ($raw | Measure-Object).count
for($i = 0; $i -lt $length; $i++){
    $output += ,@($raw[$i].Split("|")[1].TrimStart(" ").Split(" "))
    $input += ,@($raw[$i].Split("|")[0].TrimEnd(" ").Split(" "))

    #$ventlines += ,@($x1,$y1,$x2,$y2)
}

#region decode input
$digits = @("","","","","","","")
$currentDigit = ""
for($i = 0; $i -lt 1; $i++){
    #$output[$i]
    $length  = ($input[$i] | Measure-Object).count
    #$length
    #$current 
    for($j = 0; $j -lt $length; $j++){
        $charlength = ($input[$i][$j] | Measure-Object -Character).Characters
        switch($charlength){
            2 {$currentDigit = "1"
                $digits[1] = $input[$i][$j]
                $digits[2] = $input[$i][$j]
                }
            4 {$currentDigit = "4"
                $digits[5] += $input[$i][$j]
                $digits[6] += $input[$i][$j]
                #$digits[1]
                #for($k = 0; $k -lt 4; $k++){
                    
                #    if($digits[1] -Contains $input[$i][$j][$k]){
                #        Write-Output "$input[$i][$j][$k] is already in digits"
                #    }else{
                #        if($digits[2] -Contains $input[$i][$j][$k]){
                #            Write-Output "$input[$i][$j][$k] is already in digits"
                #        }else{
                #           $digits[5] = $input[$i][$j][$k]
                #           $input[$i][$j][$k]
                #           $digits[6] = $input[$i][$j][$k]
                #        }
                #
                #    }
                #}
            }
            3 {$currentDigit = "7"
                $digits[0] = $input[$i][$j]
            }
            7 {$currentDigit = "8"
                $digits[3] = $input[$i][$j]
                $digits[4] = $input[$i][$j]
            }
        }
        
        #$output[$i][$j]
    }
}
#$total = 0
#for($i = 0; $i -lt 10; $i++){
#    $total += $digits[$i]
#}
#$total
#$input[0]
#$output[0]
for($i = 0; $i -lt 7; $i++){
    Write-Output "digit $i"
    $digits[$i]
}

#endregion

$digits[0].IndexOf($digits[1])

$digits[0] = $digits[0].Substring($digits[0].IndexOf($digits[1])+2,1)
$digits[0]
#$digit[0] | Select-String $digit[1]