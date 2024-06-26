#!/bin/bash

CONNECTION_STRING="mongodb://mongodb:27017/?directConnection=true"

if [ -n "$MONGODB_INITDB_ROOT_USERNAME" ] && [ -n "$MONGODB_INITDB_ROOT_PASSWORD" ]; then
    CONNECTION_STRING="mongodb://$MONGODB_INITDB_ROOT_USERNAME:$MONGODB_INITDB_ROOT_PASSWORD@mongodb:27017/?directConnection=true"
fi


for f in /init/*; do
    # if file has sh extension, run it
    if [ ${f: -3} == ".sh" ]; then
        echo "Running $f... on $CONNECTION_STRING"
        CONNECTION_STRING=$CONNECTION_STRING bash $f
        continue
    fi

    # if file has js extension, run it with mongosh
    if [ ${f: -3} == ".js" ]; then
        echo "Running $f... on $CONNECTION_STRING"
        mongosh -f $f $CONNECTION_STRING
        continue
    fi
done