#!/bin/sh
ctags_cmd='ctags -R --c++-kinds=+p --fields=+iaS --extra=+qf --languages=C,C++'
$ctags_cmd --exclude='out' --exclude='out' --exclude='.git' --exclude='third_party'
$ctags_cmd -a third_party/WebKit
$ctags_cmd -a third_party/skia
$ctags_cmd -a third_party/dictless_lemmer

# Dumb fix for tags that are too long.
cat tags | awk "length < 512" > .tags
mv .tags tags

