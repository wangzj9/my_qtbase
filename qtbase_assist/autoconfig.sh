#!/bin/bash

path="$1"

echo "build in path: ""$path"

../configure \
-prefix "$path" \
-opensource \
-confirm-license \
-release \
-strip \
-shared \
-c++std c++11 \
-no-opengl \
-no-openssl \
-nomake examples \
-nomake tests \
-recheck-all \
