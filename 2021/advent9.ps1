$global:input = Get-Content "input9.txt"
$global:low_points = [System.Collections.ArrayList]@()
$global:count = 0
function checkN($i,$j){
    Write-Output "checking neighbor of $i $j"
    $i = [int]$i
    $j = [int]$j
    $current = $global:input[$i][$j]
    if($i -gt 0){
        $temp = $i-1
        $i_before = $global:input[$temp][$j]
    }
    if($i -lt 99){
        $temp = $i+1
        $i_next = $global:input[$temp][$j]
    }
    if($j -gt 0){
        $temp = $j-1
        $j_before = $global:input[$i][$temp]
    }
    if($j -lt 99){
        $temp = $j+1
        $j_next = $global:input[$i][$temp]
    }
    [int]$idiff = 0
    [int]$jdiff = 0

    if($i -eq 0){
        if($j -eq 0){
        #obere linke ecke
            if($i_next -lt $current){
               $idiff = 1 
            }
            #if($i_before -lt $current){
            #   $idiff = -1 
            #}
            #if($j_before -lt $current){
            #   $jdiff = -1 
            #}
            if($j_next -lt $current){
               $jdiff = 1 
            }
        }elseif($j -eq 99){
        #obere rechte ecke
            if($i_next -lt $current){
               $idiff = 1 
            }
            #if($i_before -lt $current){
            #   $idiff = -1 
            #}
            if($j_before -lt $current){
               $jdiff = -1 
            }
            #if($j_next -lt $current){
            #   $jdiff = 1 
            #}
        }else{
        #obere zeile ohne ecke
            if($i_next -lt $current){
               $idiff = 1 
            }
            #if($i_before -lt $current){
            #   $idiff = -1 
            #}
            if($j_before -lt $current){
               $jdiff = -1 
            }
            if($j_next -lt $current){
               $jdiff = 1 
            }
        }
    }elseif($i -eq 99){
        if($j -eq 0){
        #untere linke ecke
            #if($i_next -lt $current){
            #   $idiff = 1 
            #}
            if($i_before -lt $current){
               $idiff = -1 
            }
            #if($j_before -lt $current){
            #   $jdiff = -1 
            #}
            if($j_next -lt $current){
               $jdiff = 1 
            }
        }elseif($j -eq 99){
        #untere rechte ecke
            #if($i_next -lt $current){
            #   $idiff = 1 
            #}
            if($i_before -lt $current){
               $idiff = -1 
            }
            if($j_before -lt $current){
               $jdiff = -1 
            }
            #if($j_next -lt $current){
            #   $jdiff = 1 
            #}
        }else{
        #untere zeile ohne ecke
            #if($i_next -lt $current){
            #   $idiff = 1 
            #}
            if($i_before -lt $current){
               $idiff = -1 
            }
            if($j_before -lt $current){
               $jdiff = -1 
            }
            if($j_next -lt $current){
               $jdiff = 1 
            }
        }
    }elseif($j -eq 0){
        #linke spalte ohne ecke
            if($i_next -lt $current){
               $idiff = 1 
            }
            if($i_before -lt $current){
               $idiff = -1 
            }
            #if($j_before -lt $current){
            #   $jdiff = -1 
            #}
            if($j_next -lt $current){
               $jdiff = 1 
            }
    }elseif($j -eq 99){
        #rechte spalte ohne ecke
            if($i_next -lt $current){
               $idiff = 1 
            }
            if($i_before -lt $current){
               $idiff = -1 
            }
            if($j_before -lt $current){
               $jdiff = -1 
            }
            #if($j_next -lt $current){
            #   $jdiff = 1 
            #}
    }else{
        #alles andere
            if($i_next -lt $current){
               $idiff = 1 
            }
            if($i_before -lt $current){
               $idiff = -1 
            }
            if($j_before -lt $current){
               $jdiff = -1 
            }
            if($j_next -lt $current){
               $jdiff = 1 
            }


    }



    if(($idiff -eq 0)-and($jdiff -eq 0)){
        $alreadyThere = $false
        $length = ($global:low_points| Measure-Object).Count
        :outer for($k = 0; $k -lt $length; $k++){
            if(($global:low_points[$k][0] -eq $i)-and($global:low_points[$k][1] -eq $j)){
                $alreadyThere = $true
                break outer
            }

        }
        if($alreadyThere -eq $false){
            $global:low_points += ,@($i,$j) 
        }      
    }else{
        [int]$tempi = $i + $idiff
        [int]$tempj = $j + $jdiff
        $tempi
        $tempj
        ($global:low_points| Measure-Object).Count
        checkN $tempi $tempj
    }

}






    #$global:count += 1
    #true low point
    



$input = Get-Content "input9.txt"
$length = ($input | Measure-Object).count
#$input
$length
$length = ($input[0] | Measure-Object -Character).characters
$length
#$input[0][0]
#$input[1][0]
#
$saved_index_array = [System.Collections.ArrayList]@()
$rows = 100
for($i = 0; $i -lt $rows; $i++){
    $saved_index = ""
    for($j = 0; $j -lt $length; $j++){
        $currentHeight = [convert]::ToInt32($input[$i][$j],10)
        if($j -gt 0){
            $before = [convert]::ToInt32($input[$i][$j-1],10)
        }
        if($j -lt 99){
            $next = [convert]::ToInt32($input[$i][$j+1],10)
        }
        
        if($j -eq 0){
            if($currentHeight -lt $next){
                 #Write-Output "first low $currentHeight"
                 $saved_index += [string]$j + ","
            }
        }else{
            if($j -eq 99){
                if($currentHeight -lt $before){
                    #Write-Output "last low $currentHeight"
                    $saved_index += [string]$j + ","
                }
            }else{
                if(($currentHeight -lt $before)-and($currentHeight -lt $next)){
                    #Write-Output "low $currentHeight"
                    $saved_index += [string]$j + ","
                }else{

                #$currentHeight
                }
            }
        }
    }
    $saved_index_array += ,@($saved_index.TrimEnd(",").Split(","))
}
 Write-Output "array0"
$saved_index_array[0]
 Write-Output "array99"
$saved_index_array[99]

for($i = 0; $i -lt $rows; $i++){
    $length = ($saved_index_array[$i] | Measure-Object).Count
    for($j = 0; $j -lt $length; $j++){
        checkN $i $saved_index_array[$i][$j]
    }
}
#$global:low_points
($global:low_points| Measure-Object).Count
$global:low_points[0]
$global:low_points[1]
$global:low_points[2]
$global:low_points[3]
#$global:low_points[1][0]
#$global:low_points[1][1]
#$global:count

#check for doubled low points

$unique = [System.Collections.ArrayList]@()
$length = ($global:low_points| Measure-Object).Count
$total = 0
Write-Output "calculating total"
for($i = 0; $i -lt $length; $i++){
    Write-Output "koord"
    #[int]$global:low_points[$i][0]
    #[int]$global:low_points[$i][1]
    #$input[3][0]
    $currentHeight = [convert]::ToInt32($input[$global:low_points[$i][0]][$global:low_points[$i][1]],10)
    Write-Output "currentheigt"
    $currentHeight
    Write-Output "currentheigt + 1"
    $currentHeight += 1
    $currentHeight
    $total += $currentHeight
}
$total