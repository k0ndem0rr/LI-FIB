#!/bin/bash

start_measuring_time() {
  read start < <(date +'%s')
}

stop_measuring_time() {
  read end < <(date +'%s')
}

show_elapsed_time() {
  echo "$((end-start)) s"
}

for f in input/vars*.cnf
do
    echo
    echo "------------------"
    echo $f
    echo "KisSAT:"
    start_measuring_time
    ./kissat -q $f > outKisSAT
    stop_measuring_time
    egrep -o "UNSATISFIABLE|SATISFIABLE" outKisSAT
    egrep "decisions" outKisSAT
    show_elapsed_time
    echo "misat:"
    start_measuring_time
    ./misat < $f
    stop_measuring_time
    show_elapsed_time
 done
