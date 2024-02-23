#!/bin/bash

#aquest script s'executa en linux fent: bash scriptKisSAT.sh
kTime = $0
mTime = $0
start_measuring_time() {
  read start < <(date +'%s')
}

stop_measuring_time() {
  read end < <(date +'%s')
}

show_elapsed_time() {
  echo "$((end-start)) s"
}

#save_kissat_time() {
#  kTime = $((end-start))
#}

#save_misat_time() {
#  mTime = $((end-start))
#}

#show_time_ratio() {
#  if [ "$kTime" -ne 0 ]; then
#    ratio=$((mTime * 100 / kTime))
#    echo "$ratio %"
#  else
#    echo "kTime is zero, cannot compute ratio."
#  fi
#}


#for f in vars-100*.cnf
for f in input/vars*.cnf
do
    echo
    echo "------------------"
    echo $f
    echo "KisSAT:"
    start_measuring_time
    ./kissat -v $f > outKisSAT
    stop_measuring_time
    egrep -o "UNSATISFIABLE|SATISFIABLE" outKisSAT
    egrep "decisions" outKisSAT
    show_elapsed_time
    echo "misat:"
    start_measuring_time
    ./misat < $f
    stop_measuring_time
    show_elapsed_time
 #   save_misat_time
    show_elapsed_time
  #  show_time_ratio
 done