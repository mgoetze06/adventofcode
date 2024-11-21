$input = Get-Content "input5.txt"
$length = ($input | Measure-Object).count
#[convert]::ToString(63,2)

#[convert]::ToInt32('1000000',2)
#newfunction

$ventlines = [System.Collections.ArrayList]@()

for($i = 0; $i -lt $length; $i++){
    $temp = $input[$i].split(',')
    [int]$x1 = $temp[0]
    #$temp[1]
    #$temp[1].Split('->')
    [int]$y1 = $temp[1].Split('->')[0].Replace(" ","")
    [int]$x2 = $temp[1].Split('->')[2].Replace(" ","")
    [int]$y2 = $temp[2]
    #$x1 = $input[$i].Substring(0,1)
    #$y1 = $input[$i].Substring(1,1)
    #$x2 = $input[$i].Substring(7,1)
    #$y2 = $input[$i].Substring(8,1)

    #Write-output "$x1 $y1 $x2 $y2"
    $ventlines += ,@($x1,$y1,$x2,$y2)
} 
Write-output "ventline 0:"
$ventlines[0]
Write-output "ventline0 x1:"
$ventlines[0][0] #x1
$ventlines[0][1] #y1
$ventlines[0][2] #x2
$ventlines[0][3] #y2

#$ventlines[1]
$points = [System.Collections.ArrayList]@()

#New-Object 'object[5,5]' 5,5
for($i = 0; $i -lt 1000; $i++){
    if($i -eq 0){
        $initLine = (0,0,0,0,0)
        for($j = 0; $j -lt 995; $j++){
            #$initLine = [System.Collections.ArrayList]@()
            $initLine += 0
        }
        #Write-output "Asdasdasd:"
        #$initline
    }
    $points += ,(@($initLine))
    
}

#$points
#Write-output "Asdasdasd:"
#$points[0][5]
#$points[999][999]
#for($i = 0; $i -lt 1; $i++){
for($i = 0; $i -lt ($ventlines | Measure-Object).count; $i++){
    $xdiff = $ventlines[$i][2]-$ventlines[$i][0]
    $ydiff = $ventlines[$i][3]-$ventlines[$i][1]
    
    #vertical line
    if($xdiff -eq 0){ 
        $currentx = $ventlines[$i][0]
        for($k = 0; $k -lt [math]::Abs($ydiff)+1; $k++){
            if($ydiff -gt 0){
                $currenty = $ventlines[$i][1] + $k
            }
            if($ydiff -lt 0){
                $currenty = $ventlines[$i][1] - $k
            }
            $points[$currenty][$currentx] += 1
        }
    }
    #horizontal line
    if($ydiff -eq 0){
        $currenty = $ventlines[$i][1]
        for($k = 0; $k -lt [math]::Abs($xdiff)+1; $k++){
            if($xdiff -gt 0){
                $currentx = $ventlines[$i][0] + $k
            }
            if($xdiff -lt 0){
                $currentx = $ventlines[$i][0] - $k
            }
            $points[$currenty][$currentx] += 1
        }
    }
    #diagonal line
    if(($ydiff -ne 0)-and($xdiff -ne 0)){ 
        for($k = 0; $k -lt [math]::Abs($xdiff)+1; $k++){
            #$currenty = $ventlines[$i][1]
            if($xdiff -gt 0){
                $currentx = $ventlines[$i][0] + $k
            }
            if($xdiff -lt 0){
                $currentx = $ventlines[$i][0] - $k
            }
            if($ydiff -gt 0){
                $currenty = $ventlines[$i][1] + $k
            }
            if($ydiff -lt 0){
                $currenty = $ventlines[$i][1] - $k
            }
            $points[$currenty][$currentx] += 1
        }
    }

}
        
#$points[474][720]
#$points[475][720]
#$points[476][720]
#$points[477][720]
#$points[668][720]
#$points[669][720]
#$points[670][720]

#Write-output "Asdasdasd:"
#[int32[][]]$multi = @((64, 12, 24),(65, 14, 48))
#$multi[0]
$point_count = 0
for($i = 0; $i -lt 1000; $i++){
    for($j = 0; $j -lt 1000; $j++){
        if($points[$i][$j] -gt 1){
            $point_count += 1
        }
    }
}
$point_count