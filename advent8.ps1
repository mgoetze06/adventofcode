$raw = Get-Content "input8.txt"
$input = [System.Collections.ArrayList]@()
$output = [System.Collections.ArrayList]@()


$length = ($raw | Measure-Object).count
for($i = 0; $i -lt $length; $i++){
    $output += ,@($raw[$i].Split("|")[1].TrimStart(" ").Split(" "))
    $input += ,@($raw[$i].Split("|")[0].TrimEnd(" ").Split(" "))

    #$ventlines += ,@($x1,$y1,$x2,$y2)
}


$digits = @(0,0,0,0,0,0,0,0,0,0)
for($i = 0; $i -lt 200; $i++){
    #$output[$i]
    $length  = ($output[$i] | Measure-Object).count
    #$length
    for($j = 0; $j -lt $length; $j++){
        $charlength = ($output[$i][$j] | Measure-Object -Character).Characters
        switch($charlength){
            2 {$digits[2] += 1}
            4 {$digits[4] += 1}
            3 {$digits[7] += 1}
            7 {$digits[8] += 1}
        }
        
        #$output[$i][$j]
    }
}
$total = 0
for($i = 0; $i -lt 10; $i++){
    $total += $digits[$i]
}
$total
#$input[0]
#$output[0]


