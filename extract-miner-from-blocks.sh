#!/bin/bash

extract-miner() {
    height=`./hdac-cli hdac getinfo 2> /dev/zero | jq ".blocks"`
    for i in $(seq 0 $height)
    do
        #echo $i        
        echo $i : `./hdac-cli hdac getblock $i 2> /dev/zero | jq ".miner"` >> miner.log
    done
}

rm miner.log
extract-miner