#!/bin/sh


g1=""
g2=""
nodename=""
for i in $@
do

   echo "value of i is:" $i
   case $i in
       
       # -- option

       --nodename) 
             nodename="$i"
	     shift 4
             ;; 
       
       --*) g1="${g1} $i"; g=1;;

       # - option
       -*) g2="${g2} $i"; g=2;;
       
       # Parameter 
       *) p=$i
          if [ "$g" = 1 ]
          then
            g1="${g1} $p"
            g=0
          elif [ "$g" = 2 ]
          then
            g2="${g2} $p"
            g=0
          else
            others="$others $p"
          fi
      ;;
 
   esac

done
echo g1=$g1
echo g2=$g2
echo others=$others
echo nodnename=$nodename
