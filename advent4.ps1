function draw{
    param($allboards,$index)
    Write-Output "bingo board $index"
    Write-Output ""
    for($i = 0; $i -lt 5; $i++){
        for($j = 0; $j -lt 5; $j++){
            $string += $allboards[$index][$i][$j] + " "
        }  
        Write-Output $string
        $string = ""
    }
     Write-Output ""
}



$input = Get-Content "input_advent4.txt"
#$length = ($input | Measure-Object).count
#$input[0].Substring(0,1)
$numbers =  $input[0].Split(",")
$totalnumbers=($numbers | Measure-Object).count

$raw_lines = [System.Collections.ArrayList]@()

$boards = [System.Collections.ArrayList]@()
#$array = New-Object 'object[,]' 5,5
for($j = 0; $j -lt 31; $j++){
    $linecount = 2 + $j*6
    $array = [System.Collections.ArrayList]@()
    for($i = $linecount; $i -lt ($linecount+5); $i++){
        $raw_lines = $input[$i].Replace("  "," ").Split(" ")
        $array += ,@($raw_lines)
        #for($j = 0; $j -lt 5; $j++){
            #$a = $i -2
            #$array[$a,$j] = $raw_lines[$j]
       # }
    }
#$array
    $boards += ,@($array)
}
#$boards[0]
#$boards[1]

draw -allboards $boards -index 30