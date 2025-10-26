#!/usr/bin/env sh
# inspired by https://sethmlarson.dev/easy-github-co-authored-by
test $1 && gh api "/users/$1" | jq -r '"Co-authored-by: \(.name // .login) <\(.id)+\(.login)@users.noreply.github.com>"'
