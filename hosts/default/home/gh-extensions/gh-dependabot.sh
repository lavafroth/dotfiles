#!/usr/bin/env sh
gh api notifications | jq '.[] | select(.reason == "subscribed" and .subject.type == "PullRequest") | {title: .subject.title, repository: .repository.full_name, pr: .subject.url | split("/")[-1] }'
