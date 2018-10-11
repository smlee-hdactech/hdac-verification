#!/bin/bash

grap_txids_from_blocks_without_coinbase() {
    declare -A txm
    bh=`./hdac-cli $1 getinfo | ./jq ".blocks"`
    for i in $(seq 0 $bh)    
    #for i in $(seq 0 1)
    do
        txids=`./hdac-cli $1 getblock $i 2> /dev/zero | ./jq -r ".tx[]"`
        #echo "$txids"
        index=0
        for txid in $txids
        do
            #echo "txid=$txid"
            if [ $index -gt 0 ]; then
               txm[$txid]=1
            fi
            ((index++))
        done        
    done
    echo "count of txids except coinbase from getblock=${#txm[@]}"
    echo "the result of txids_grap_duplicate should be $(($bh + ${#txm[@]} * 2))"
    #echo "coinbase tx from genesis block should be removed, final count=$((${#txm[@]}-1))"
}

txids_grab_duplicate() {
    declare -a txa
    #for address in $1
    for address in $address_list
    do
        #echo $address
        txids=`./hdac-cli $1 getaddresstxids '{"addresses": ["'$address'"]}' 2> /dev/zero | ./jq -r ".[]"`

        for txid in $txids
        do
            #echo "txid=$txid"
            txa+=($txid)
        done
    #txids_arr="${txids}"
    #echo ${txids_arr[0]}
    done
    echo "count of txids from getaddresstxids=${#txa[@]}"
}

#address_list="HCh1rUtKocpMRnL1qAzc1b9uhmDBLa1pqC HVSKSFGsipZPZPXgMrwqSs5dWioNSkk9DA"
#address_list="HVZJJJwjDoZM79k6jw4JYKcUbz5wefdzM8 H7B6zsficEvpQAVExhr5x778E7Rn5YV8G1 HH2jHFqhTZ9eBUR66HeMsc768QxcGGV14u HHkKMQFx5gqW8Zcx3PhGAJNYyg5rc6DGZG HNHqmkZZ58H54u7HCoua4h7HSsbd1EyXUi HSRTLgtey15MwDtGDf1Ku51eQQYBg74x3n HL9zoDhR1NE3QkyGneJanuSRobWqLSEPEE HEaXKXV3F482Mf8nJ8y6qWTBb95CcFZxPu H7qVVzccjwaBqRAtUj6Aqu7V6cJAEv2hXm HMuht2yHQdi5KLz46qSmney5JZRfjwn1YN HDFd45jQ1e6khUwojLd8ndFWa6QJd5ntVz HSapDck1gwLYKr1wZEVZPuv1ZY5QPBGekM"
address_list="HVZJJJwjDoZM79k6jw4JYKcUbz5wefdzM8 "
address_list+="H7B6zsficEvpQAVExhr5x778E7Rn5YV8G1 "
address_list+="HH2jHFqhTZ9eBUR66HeMsc768QxcGGV14u "
address_list+="HHkKMQFx5gqW8Zcx3PhGAJNYyg5rc6DGZG "
address_list+="HNHqmkZZ58H54u7HCoua4h7HSsbd1EyXUi "
address_list+="HSRTLgtey15MwDtGDf1Ku51eQQYBg74x3n "
address_list+="HL9zoDhR1NE3QkyGneJanuSRobWqLSEPEE "
address_list+="HEaXKXV3F482Mf8nJ8y6qWTBb95CcFZxPu "
address_list+="H7qVVzccjwaBqRAtUj6Aqu7V6cJAEv2hXm "
address_list+="HMuht2yHQdi5KLz46qSmney5JZRfjwn1YN "
address_list+="HDFd45jQ1e6khUwojLd8ndFWa6QJd5ntVz "
address_list+="HSapDck1gwLYKr1wZEVZPuv1ZY5QPBGekM"

net_name="ttx"
if [ -n "$1" ]; then
    net_name="$1"
fi

grap_txids_from_blocks_without_coinbase $net_name
txids_grab_duplicate $net_name
