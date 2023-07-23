#!/usr/bin/env bash

pkg="$(basename -- $1)"
pkgExtension="${pkg##*.}"
pkgName="${pkg%.*}"

