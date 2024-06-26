#!/bin/bash

# Fetch data
wget https://raw.githubusercontent.com/neelabalan/mongodb-sample-dataset/main/sample_mflix/movies.json -O /tmp/movies.json

# import it with mongoimport
mongoimport --uri $CONNECTION_STRING --collection=movies --db=mflix --authenticationDatabase=admin --file=/tmp/movies.json