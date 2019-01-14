#!/usr/bin/env bash

# create csv folders
mkdir data/intermediate/2015
mkdir data/intermediate/2016
mkdir data/intermediate/2017
mkdir data/intermediate/2018

# copy html files new directory for csv
cp -r data/raw/2015/* data/intermediate/2015

# change file extensions
for file in data/intermediate/2015/*.html
do
  mv "$file" "${file%%.*}.${file##*.}"
done

for file in data/intermediate/2015/*.html
do
  mv "$file" "${file%.html}.csv"
done

# copy html files new directory for csv
cp -r data/raw/2016/* data/intermediate/2016

# change file extensions
for file in data/intermediate/2016/*.html
do
  mv "$file" "${file%%.*}.${file##*.}"
done

for file in data/intermediate/2016/*.html
do
  mv "$file" "${file%.html}.csv"
done

# copy html files new directory for csv
cp -r data/raw/2017/* data/intermediate/2017

# change file extensions
for file in data/intermediate/2017/*.html
do
  mv "$file" "${file%%.*}.${file##*.}"
done

for file in data/intermediate/2017/*.html
do
  mv "$file" "${file%.html}.csv"
done

# copy html files new directory for csv
cp -r data/raw/2018/* data/intermediate/2018

# change file extensions
for file in data/intermediate/2018/*.html
do
  mv "$file" "${file%%.*}.${file##*.}"
done

for file in data/intermediate/2018/*.html
do
  mv "$file" "${file%.html}.csv"
done