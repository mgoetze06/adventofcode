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
$rows = 200
$total = 0
for($i = 0; $i -lt $rows; $i++){
    Write-Output "output"
    $output[$i]
    Write-Output "input"
    $input[$i]
    $length  = ($input[$i] | Measure-Object).count
    #$length
    #$current 
    $digits = @("","","","","","","")
    for($j = 0; $j -lt $length; $j++){
        $charlength = ($input[$i][$j] | Measure-Object -Character).Characters
        switch($charlength){ #eindeutige Zuordnugnen
            2 {$currentDigit = "1"
                $digits[1] = $input[$i][$j]
                $digits[2] = $input[$i][$j]
                }
            4 {$currentDigit = "4"
                $digits[5] += $input[$i][$j]
                $digits[6] += $input[$i][$j]
            }
            3 {$currentDigit = "7"
                $digits[0] = $input[$i][$j]
            }
            7 {$currentDigit = "8"
                $digits[3] = $input[$i][$j]
                $digits[4] = $input[$i][$j]
            }

        }
        }
        $digits[0] = $digits[0].Replace($digits[1].Substring(0,1),"")
        $digits[0] = $digits[0].Replace($digits[1].Substring(1,1),"")
        $digits[5] = $digits[5].Replace($digits[1].Substring(0,1),"")
        $digits[5] = $digits[5].Replace($digits[1].Substring(1,1),"")
        $digits[6] = $digits[6].Replace($digits[1].Substring(0,1),"")
        $digits[6] = $digits[6].Replace($digits[1].Substring(1,1),"")

        $digits[4] = $digits[4].Replace($digits[1].Substring(1,1),"")
        $digits[4] = $digits[4].Replace($digits[1].Substring(0,1),"")
        $digits[4] = $digits[4].Replace($digits[0].Substring(0,1),"")
        $digits[4] = $digits[4].Replace($digits[6].Substring(0,1),"")
        $digits[4] = $digits[4].Replace($digits[6].Substring(1,1),"")
        $digits[3] = $digits[4]
        Write-Output "digits replaced"
        for($s = 0; $s -lt 7; $s++){
            Write-Output "digit $s"
            $digits[$s]
    
        }
        $string = ""
        Write-Output "decoding output"
        $length  = ($output[$i] | Measure-Object).count
        for($j = 0; $j -lt $length; $j++){
            $charlength = ($output[$i][$j] | Measure-Object -Character).Characters
            $current = $output[$i][$j]
            $current
            switch($charlength){  
             2 {$currentDigit = "1"}
             3 {$currentDigit = "7"}
             7 {$currentDigit = "8"}
             4 {$currentDigit = "4"}
             6 { #entweder 0 6 oder 9 dargestellt
                Write-Output "6 chars"

                if(($current -match $digits[1].Substring(0,1))-and($current -match $digits[1].Substring(1,1))-and($current -match $digits[5].Substring(1,1))-and($current -match $digits[5].Substring(0,1))){
                    #displayed digit is 9
                    Write-Output "digit is 9"
                    $currentDigit = "9"
                }else{
                    if(($current -match $digits[5].Substring(1,1))-and($current -match $digits[5].Substring(0,1))){
                        #displayed digit is 6
                        Write-Output "digit is 6"
                        $currentDigit = "6"
                    }else{
                        Write-Output "digit is 0"
                        $currentDigit = "0"
                    }
                }
                    

                #if($input[$i][$j] -contains 
             }
             5{ #entweder 2 3 oder 5 dargestellt
                Write-Output "5 chars"
                if(($current -match $digits[1].Substring(0,1))-and($current -match $digits[1].Substring(1,1))){
                    Write-Output "digit is 3"
                    $currentDigit = "3"
                }else{
                    if(($current -match $digits[5].Substring(0,1))-and($current -match $digits[5].Substring(1,1))){
                        Write-Output "digit is 5"
                        $currentDigit = "5"
                    }else{
                        Write-Output "digit is 2"
                        $currentDigit = "2"
                    }
                }

             } 
            }

            $string += $currentDigit
            $currentDigit = ""
            $string
        }
        Write-Output "string"
        $string
        Write-Output "int"
        [int]$string
        Write-Output "total"
        $total
        $total += [int]$string
        $total
        #$output[$i][$j]
    
}
$total
#$total = 0
#for($i = 0; $i -lt 10; $i++){
#    $total += $digits[$i]
#}
#$total
#$input[0]
#$output[0]

#endregion

#$digits[0].IndexOf($digits[1])


#$digits[0] = $digits[0].Substring($digits[0].IndexOf($digits[1])+2,1)
#$digits[0]





#$digit[0] | Select-String $digit[1]


#this is a changeasdasd
