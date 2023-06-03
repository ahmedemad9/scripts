#!/bin/bash
input="/home/ahmed/Desktop/Senior2/Semester2/GP/codes/gen/full_controller_ports_description.csv"
i=0
while IFS="," read -r direction type width name_un
do
  name=$(sed 's/,/\t/g' <<< $name_un)
  #echo $line 
  if [ $i -eq 0 ] 
  then
      printf "module %s_tb();\n" $direction
  else
    arr_w=$(expr $width)
    arr_w=$((arr_w-1))
    if [ $arr_w -gt 0 ]
    then
        if [ "$direction" = "In" ] || [  "$direction" = "in" ]
        then
            printf "wire %s_tb\t\t[%d    :   0];\n" $name $arr_w
        elif [ "$direction" = "Out" ] || [ "$direction" = "out" ]
        then
            printf "reg  %s_tb\t\t[%d    :   0];\n" $name $arr_w
        fi
    else
        if [ "$direction" = "In" ] ||  [ "$direction" = "in" ]
        then
            printf "wire %s_tb;\n" $name 
        elif [ "$direction" = "Out" ] || [ "$direction" = "out" ]
        then
            printf "reg  %s_tb;\n" $name
        fi

    fi
  fi
  i=$((i+1))
done < "$input"


printf "\n\nh_clk=5;\nf_clk=2*h_clk;\nalways #half_clk clk_tb=!clk_tb;"

printf "inital begin\n\nend"

input="/home/ahmed/Desktop/Senior2/Semester2/GP/codes/gen/full_controller_ports_description.csv"
i=0
while IFS="," read -r direction type width name_un
do
  name=$(sed 's/,/\t/g' <<< $name_un)
  #echo $line 
  if [ $i -eq 0 ] 
  then
    printf "\n\n%s DUT(\n" $direction
  else
      printf "\t .%s(%s_tb),\n" $name $name
  fi
  i=$((i+1))
done < "$input"
printf ")\nendmodule"
