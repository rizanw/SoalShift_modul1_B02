#!/bin/bash

unzip nature.zip
cd nature/

for foto in *
do
    base64 -d "$foto" | xxd -r > "$foto-tmp"
    rm "$foto"
    mv "$foto-tmp" "$foto"
done
