#!/bin/bash
# Script to fix libpng issue which produces these warnings:
#   libpng warning: iCCP: known incorrect sRGB profile
#
# Requires mogrify from imagemagick

find -name "*.png" | xargs -r -- mogrify

