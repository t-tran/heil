#!/bin/bash

rm -rf release
mkdir release

go build -v .
version=$(./heil -version)
rm -rf heil

export GOARCH="386"
export GOOS=linux
echo Building $GOOS $GOARCH
go build -v .
zip release/heil_${version}_${GOOS}_${GOARCH}.zip heil
rm -rf heil

export GOARCH=amd64
export GOOS=linux
echo Building $GOOS $GOARCH
go build -v .
zip release/heil_${version}_${GOOS}_${GOARCH}.zip heil
rm -rf heil

export GOARCH="arm"
export GOOS=linux
echo Building $GOOS $GOARCH
go build -v .
zip release/heil_${version}_${GOOS}_${GOARCH}.zip heil
rm -rf heil

export GOARCH=arm64
export GOOS=linux
echo Building $GOOS $GOARCH
go build -v .
zip release/heil_${version}_${GOOS}_${GOARCH}.zip heil
rm -rf heil

export GOARCH=amd64
export GOOS=darwin
echo Building $GOOS $GOARCH
go build -v .
zip release/heil_${version}_${GOOS}_${GOARCH}.zip heil
rm -rf heil

export GOARCH="386"
export GOOS=windows
echo Building $GOOS $GOARCH
go build -v .
zip release/heil_${version}_${GOOS}_${GOARCH}.zip heil.exe
rm -rf heil.exe

export GOARCH=amd64
export GOOS=windows
echo Building $GOOS $GOARCH
go build -v .
zip release/heil_${version}_${GOOS}_${GOARCH}.zip heil.exe
rm -rf heil.exe
