﻿function draw{
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
$marked_lines = ("0","0","0","0","0")

$boards = [System.Collections.ArrayList]@()
$marked_boards = [System.Collections.ArrayList]@()
#$array = New-Object 'object[,]' 5,5
for($j = 0; $j -lt 100; $j++){
    $linecount = 2 + $j*6
    $array = [System.Collections.ArrayList]@()
    $marked_array = [System.Collections.ArrayList]@()
    for($i = $linecount; $i -lt ($linecount+5); $i++){
        if($input[$i][0] -eq " "){
            $input[$i] = $input[$i].Substring(1,13)
        }
        $raw_lines = $input[$i].Replace("  "," ").Split(" ")
        $array += ,@($raw_lines)
        $marked_array += ,@($marked_lines)
        #for($j = 0; $j -lt 5; $j++){
            #$a = $i -2
            #$array[$a,$j] = $raw_lines[$j]
       # }
    }
#$array
    $boards += ,@($array)
    $marked_boards += ,@($marked_array)
}
#$boards[0]
#$boards[1]
#($boards | Measure-Object).count
#draw -allboards $boards -index 99
#draw -allboards $marked_boards -index 99

#$marked_boards[99][0][0] = "1"
#draw -allboards $marked_boards -index 99

:number for($n = 0; $n -lt $totalnumbers; $n++){
    #checkhit -allboards $boards -allmarkedboards $marked_boards -number $numbers[$j]
    for($a = 0; $a -lt 100; $a++){
    #boards
        #mark new shot
        for($i = 0; $i -lt 5; $i++){
        #rows
            for($j = 0; $j -lt 5; $j++){
            #columns
                if($boards[$a][$i][$j] -eq $numbers[$n]){
                    $marked_boards[$a][$i][$j] = "1"
                }
            }
        }
        #check if board is winner
        $winner = -1
        for($i = 0; $i -lt 5; $i++){
            if(($marked_boards[$a][$i][0] -eq "1")-and($marked_boards[$a][$i][1] -eq "1")-and($marked_boards[$a][$i][2] -eq "1")-and($marked_boards[$a][$i][3] -eq "1")-and($marked_boards[$a][$i][4] -eq "1")){
                #board is winner
                $winner = $a
            }
        }
        for($j = 0; $j -lt 5; $j++){
            if(($marked_boards[$a][0][$j] -eq "1")-and($marked_boards[$a][1][$j] -eq "1")-and($marked_boards[$a][2][$j] -eq "1")-and($marked_boards[$a][3][$j] -eq "1")-and($marked_boards[$a][4][$j] -eq "1")){
                #board is winner
                $winner = $a
            }
        }
        if($winner -gt -1){
            $winningNumber = $numbers[$n]
            break number
        }
    }
    
}
Write-Output "winning number: $winningNumber"
draw -allboards $marked_boards -index $winner
draw -allboards $boards -index $winner
#draw -allboards $marked_boards -index 5
#draw -allboards $boards -index 5

$sum_notmarked = 0
for($i = 0; $i -lt 5; $i++){
    for($j = 0; $j -lt 5; $j++){
        if($marked_boards[$winner][$i][$j] -eq "0"){
            $sum_notmarked += [int]$boards[$winner][$i][$j]
        }
    }
}
$sum_notmarked * $winningNumber