#!/bin/bash

generate_tx() {
    balance=`./hdac-cli ttx getaddressbalances $1 | ./jq ".[0].qty"`
    echo "current balance is $balance"

    for i in $(seq 1 $3)
    do
    ./hdac-cli ttx sendfrom $1 $2 1
    done

    echo "balance should be `echo "$balance - $3 - $3 * 0.01" | bc`"
    echo "getbalance result: `./hdac-cli ttx getaddressbalances $1 | ./jq ".[0].qty"`"
    echo "if result is different from the desired value, you need to wait until a new block is generated"
}

#generate_tx HBRaopfYWSgp7A4H1ePbra4L3KeJPD6kGw HCsM51qurhzv2tK49MoqdV1CdfMpQU3vVr 2
