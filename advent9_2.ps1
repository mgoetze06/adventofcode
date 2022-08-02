$global:input = Get-Content "input9.txt"
$global:low_points = [System.Collections.ArrayList]@()
$global:basin_points = [System.Collections.ArrayList]@()
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
        #$tempi
        #$tempj
        #($global:low_points| Measure-Object).Count
        checkN $tempi $tempj
    }

}


function checkbasin($i,$j){
    Write-Output "checking basin of $i $j"
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
    $versuche_left = 4 #für 4 mögliche Richtungen

    $ignore_inext = $false
    $ignore_ibefore = $false
    $ignore_jnext = $false
    $ignore_jbefore = $false
    while($versuche_left -ne 0){
	Write-Output "Versuche left: $versuche_left"
    if($i -eq 0){
        if($j -eq 0){
        #obere linke ecke
        Write-Output "oben links"
            $versuche_left -= 2
            if(($i_next -ge $current) -and ($i_next -ne 9)-and($ignore_inext -eq $false)){
               $idiff = 1
               $ignore_inext = $true
            }
            #if($i_before -lt $current){
            #   $idiff = -1 
            #}
            #if($j_before -lt $current){
            #   $jdiff = -1 
            #}
            elseif(($j_next -ge $current) -and ($j_next -ne 9)-and($ignore_jnext -eq $false)){
               $jdiff = 1 
               $ignore_jnext = $true
            }
        }elseif($j -eq 99){
        #obere rechte ecke
        Write-Output "oben rechts"
            $versuche_left -= 2
            if(($i_next -ge $current) -and ($i_next -ne 9)-and($ignore_inext -eq $false)){
               $idiff = 1 
               $ignore_inext = $true
            }
            #if($i_before -lt $current){
            #   $idiff = -1 
            #}
            elseif(($j_before -ge $current) -and ($j_before -ne 9)-and($ignore_jbefore -eq $false)){
               $jdiff = -1 
               $ignore_jbefore = $true
            }
            #if($j_next -lt $current){
            #   $jdiff = 1 
            #}
        }else{
        #obere zeile ohne ecke
        Write-Output "oben zeile ohne ecke"
            if(($i_next -ge $current) -and ($i_next -ne 9)-and($ignore_inext -eq $false)){
               $idiff = 1 
               $ignore_inext = $true
               $versuche_left -= 1
            }
            #if($i_before -lt $current){
            #   $idiff = -1 
            #}
            elseif(($j_before -ge $current) -and ($j_before -ne 9)-and($ignore_jbefore -eq $false)){
               $jdiff = -1 
               $ignore_jbefore = $true
               $versuche_left -= 1
            }
            elseif(($j_next -ge $current) -and ($j_next -ne 9)-and($ignore_jnext -eq $false)){
               $jdiff = 1 
               $ignore_jnext = $true
               $versuche_left -= 1
            }
        }
    }elseif($i -eq 99){
        if($j -eq 0){
        Write-Output "unten links"
        #untere linke ecke
            $versuche_left -= 2
            #if($i_next -lt $current){
            #   $idiff = 1 
            #}
            if(($i_before -ge $current) -and ($i_before -ne 9)-and($ignore_ibefore -eq $false)){
               $idiff = -1 
               $ignore_ibefore = $true
            }
            #if($j_before -lt $current){
            #   $jdiff = -1 
            #}
            elseif(($j_next -ge $current) -and ($j_next -ne 9)-and($ignore_jnext -eq $false)){
               $jdiff = 1 
               $ignore_jnext = $true
            }
        }elseif($j -eq 99){
        Write-Output "unten rechts"
        #untere rechte ecke
            $versuche_left -= 2
            #if($i_next -lt $current){
            #   $idiff = 1 
            #}
            if(($i_before -ge $current) -and ($i_before -ne 9)-and($ignore_ibefore -eq $false)){
               $idiff = -1 
               $ignore_ibefore = $true
            }
            elseif(($j_before -ge $current) -and ($j_before -ne 9)-and($ignore_jbefore -eq $false)){
               $jdiff = -1 
               $ignore_jbefore = $true
            }
            #if($j_next -lt $current){
            #   $jdiff = 1 
            #}
        }else{
        Write-Output "unten ohne ecken"
        #untere zeile ohne ecke
            #if($i_next -lt $current){
            #   $idiff = 1 
            #}
            if(($i_before -ge $current) -and ($i_before -ne 9)-and($ignore_ibefore -eq $false)){
               $idiff = -1 
               $ignore_ibefore = $true
               $versuche_left -= 1
            }
            elseif(($j_before -ge $current) -and ($j_before -ne 9)-and($ignore_jbefore -eq $false)){
               $jdiff = -1 
               $ignore_jbefore = $true
               $versuche_left -= 1
            }
            elseif(($j_next -ge $current) -and ($j_next -ne 9)-and($ignore_jnext -eq $false)){
               $jdiff = 1 
               $ignore_jnext = $true
               $versuche_left -= 1
            }
        }
    }elseif($j -eq 0){
        Write-Output "linke spalte"
		Write-Output "current: $current"
		Write-Output "inext: $i_next  ibefore: $i_before  jnext: $j_next  jbefore: $j_before"
        #linke spalte ohne ecke
            if(($i_next -ge $current) -and ($i_next -ne 9)-and($ignore_inext -eq $false)){
               $idiff = 1 
               $ignore_inext = $true
               $versuche_left -= 1
			   Write-Output "linke spalte1"
            }
            elseif(($i_before -ge $current) -and ($i_before -ne 9)-and($ignore_ibefore -eq $false)){
               $idiff = -1 
               $ignore_ibefore = $true
               $versuche_left -= 1
			   Write-Output "linke spalte2"
            }
            #if($j_before -lt $current){
            #   $jdiff = -1 
            #}
            elseif(($j_next -ge $current) -and ($j_next -ne 9)-and($ignore_jnext -eq $false)){
               $jdiff = 1 
               $ignore_jnext = $true
               $versuche_left -= 1
			   Write-Output "linke spalte3"
            }
		Write-Output "idiff: $idiff ,jdiff: $jdiff"
    }elseif($j	-eq 99){
    Write-Output "rechte spalte"
        #rechte spalte ohne ecke
            if(($i_next -ge $current) -and ($i_next -ne 9)-and($ignore_inext -eq $false)){
               $idiff = 1 
               $ignore_inext = $true
               $versuche_left -= 1
            }
            elseif(($i_before -ge $current) -and ($i_before -ne 9)-and($ignore_ibefore -eq $false)){
               $idiff = -1 
               $ignore_ibefore = $true
               $versuche_left -= 1
            }
            elseif(($j_before -ge $current) -and ($j_before -ne 9)-and($ignore_jbefore -eq $false)){
               $jdiff = -1 
               $ignore_jbefore = $true
               $versuche_left -= 1
            }
            #if($j_next -lt $current){
            #   $jdiff = 1 
            #}
    }else{
        #alles andere
        Write-Output "kein Rand"
            if(($i_next -ge $current) -and ($i_next -ne 9)-and($ignore_inext -eq $false)){
               $idiff = 1 
               $ignore_inext = $true
               $versuche_left -= 1
            }
            elseif(($i_before -ge $current) -and ($i_before -ne 9)-and($ignore_ibefore -eq $false)){
               $idiff = -1 
               $ignore_ibefore = $true
               $versuche_left -= 1
            }
            elseif(($j_before -ge $current) -and ($j_before -ne 9)-and($ignore_jbefore -eq $false)){
               $jdiff = -1 
               $ignore_jbefore = $true
               $versuche_left -= 1
            }
            elseif(($j_next -ge $current) -and ($j_next -ne 9)-and($ignore_jnext -eq $false)){
               $jdiff = 1 
               $ignore_jnext = $true
               $versuche_left -= 1
            }


    }



    if(($idiff -eq 0)-and($jdiff -eq 0)){
        #nothing happens = end of basin reached     




    }else{
		Write-Output "i: $i ,j: $j"
        [int]$tempi = $i + $idiff
        [int]$tempj = $j + $jdiff
		Write-Output "tempi:  $tempi , tempj: $tempj"
        $alreadyThere = $false
        $length = ($global:basin_points| Measure-Object).Count
		$length
        :outer for($k = 0; $k -lt $length; $k++){
            if(($global:basin_points[$k][0] -eq $tempi)-and($global:basin_points[$k][1] -eq $tempj)){
                $alreadyThere = $true
				Write-Output "basin point already there"
				#Write-Output "all basin points: $global:basin_points"
				$versuche_left = 0
                break outer
            }
            

        }
        if($alreadyThere -eq $false){
			Write-Output "need to add point to basin points ($tempi,$tempj)"
            #$global:basin_points += ,@($i,$j)
			$global:basin_points += ,@($tempi,$tempj)
			$global:basin_length += 1
			
			#$global:basin_length
			#($global:basin_points| Measure-Object).Count
			#Write-Output "all points:"
			
            #checkbasin $i $j 
        }  
		
		
		 if($tempi -gt 0){
			$temp = $tempi-1
			$i_before = $global:input[$temp][$tempj]
		}
		if($tempi -lt 99){
			$temp = $tempi+1
			$i_next = $global:input[$temp][$tempj]
		}
		if($tempj -gt 0){
			$temp = $tempj-1
			$j_before = $global:input[$tempi][$temp]
		}
		if($tempj -lt 99){
			$temp = $tempj+1
			$j_next = $global:input[$tempi][$temp]
		}
		$current = $global:input[$tempi][$tempj]
		Write-Output "i: $i ,j: $j"

		Write-Output "tempi:  $tempi , tempj: $tempj"
		
        #($global:low_points| Measure-Object).Count
        
    }
    }
}





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
 #Write-Output "array0"
#$saved_index_array[0]
# Write-Output "array99"
#$saved_index_array[99]

for($i = 0; $i -lt $rows; $i++){
    $length = ($saved_index_array[$i] | Measure-Object).Count
    for($j = 0; $j -lt $length; $j++){
        checkN $i $saved_index_array[$i][$j]
    }
}
#$global:low_points
Write-Output "total lowpoints"
($global:low_points| Measure-Object).Count
Write-Output "low point 0"
$global:low_points[0][0]
$global:low_points[0][1]
Write-Output ""
$global:low_points[0]
#$global:low_points[1][0]
#$global:low_points[1][1]
#$global:count


$global:basin_length = 0
$length = ($global:low_points| Measure-Object).Count
$total = 0
Write-Output "calculating total"
#for($i = 0; $i -lt $length; $i++){
    #Write-Output "koord"
    #[int]$global:low_points[$i][0]
    #[int]$global:low_points[$i][1]
    #$input[3][0]
#    $currentHeight = [convert]::ToInt32($input[$global:low_points[$i][0]][$global:low_points[$i][1]],10)
    #Write-Output "currentheigt"
    #$currentHeight
    #Write-Output "currentheigt + 1"
#    $currentHeight += 1
    #$currentHeight
#    $total += $currentHeight
#}
#$total
Write-Output "checking basins"
#for($i = 0; $i -lt $length; $i++){
checkbasin $global:low_points[0][0] $global:low_points[0][1]
#}
$global:basin_length