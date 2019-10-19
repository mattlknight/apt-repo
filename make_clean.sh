#!/bin/bash

find . -type f \( \
        -name Release \
        -o -name Release.gpg \
        -o -name InRelease \
        -o -name Packages \
        -o -name Packages.bz2 \
        -o -name Packages.gz \
        -o -name Contents-amd64 \
        -o -name Contents-amd64.bz2 \
        -o -name Contents-amd64.gz \
        \) -a -delete