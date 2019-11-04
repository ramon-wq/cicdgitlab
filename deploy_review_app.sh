#!/usr/bin/env bash
set -x
set -e

export CI_ENVIRONMENT_SLUG=`echo $TRAVIS_PULL_REQUEST_BRANCH | sed 's/[^a-z0-9]/-/g'`
echo "Deploying $CI_ENVIRONMENT_SLUG to git-shoutout-${CI_ENVIRONMENT_SLUG}.us-west-2.elasticbeanstalk.com"
