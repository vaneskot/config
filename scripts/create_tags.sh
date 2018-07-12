#!/bin/sh
ctags_cmd='ctags -R --c++-kinds=+p --fields=+iaS --extra=+qf --languages=C,C++,Java'
$ctags_cmd --exclude='out' --exclude='.git' --exclude='third_party' --exclude='browsec'
$ctags_cmd -a third_party/blink

# Dumb fix for tags that are too long.
cat tags | awk "length < 512" > .tags
mv .tags tags
