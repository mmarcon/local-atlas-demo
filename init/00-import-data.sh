#!/bin/bash

# Fetch data
wget https://raw.githubusercontent.com/neelabalan/mongodb-sample-dataset/main/sample_mflix/movies.json -O /tmp/movies.json

# import it with mongoimport
mongoimport --uri mongodb://mongodb:27017 --collection=movies --db=mflix --file=/tmp/movies.json