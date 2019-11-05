#!/usr/bin/env bash
set -x
set -e

echo "Deploying $CI_ENVIRONMENT_SLUG to git-shoutout-${CI_ENVIRONMENT_SLUG} for review/${CI_ENVIRONMENT_SLUG}"
