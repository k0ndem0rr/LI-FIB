#!/bin/bash

#aquest script s'executa en linux fent: bash scriptMiSAT.sh

start_measuring_time() {
  read start < <(date +'%s')
}

stop_measuring_time() {
  read end < <(date +'%s')
}

show_elapsed_time() {
  echo "$((end-start)) s"
}

#for f in vars-100*.cnf
for f in input/vars*.cnf
do
    echo
    echo "------------------"
    echo $f
    echo "misat og:"
    start_measuring_time
    ./misatog < $f
    stop_measuring_time
    show_elapsed_time
    echo "misat:"
    start_measuring_time
    ./misat < $f
    stop_measuring_time
    show_elapsed_time
  done