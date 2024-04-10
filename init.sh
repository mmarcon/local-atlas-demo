#!/bin/bash

for f in /init/*; do
    # if file has sh extension, run it
    if [ ${f: -3} == ".sh" ]; then
        echo "Running $f..."
        bash $f
        continue
    fi

    # if file has js extension, run it with mongosh
    if [ ${f: -3} == ".js" ]; then
        echo "Running $f..."
        mongosh -f $f mongodb://mongodb:27017/?directConnection=true
        continue
    fi
done