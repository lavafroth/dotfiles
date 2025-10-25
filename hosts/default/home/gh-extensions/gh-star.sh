#!/usr/bin/env sh
test "$@" && gh api -X PUT "/user/starred/$1"
