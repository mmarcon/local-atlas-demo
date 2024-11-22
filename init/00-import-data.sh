#!/bin/bash

# Fetch data
curl -o /tmp/movies.json https://raw.githubusercontent.com/neelabalan/mongodb-sample-dataset/main/sample_mflix/movies.json

# import it with mongoimport and log an error if it fails
mongoimport --uri $CONNECTION_STRING --collection=movies --db=mflix --file=/tmp/movies.json || echo "Failed to import data" > /tmp/import-error.txt