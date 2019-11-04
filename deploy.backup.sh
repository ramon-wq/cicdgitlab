#!/usr/bin/env bash
set -x
set -e

echo "Deploying $CI_ENVIRONMENT_SLUG to git-shoutout-${CI_ENVIRONMENT_SLUG} for review/${CI_ENVIRONMENT_SLUG}"

if [ ! -z "$(eb list | grep "${CI_ENVIRONMENT_SLUG}")" ]
then
    echo "Updating existing environment"
    eb deploy "$CI_ENVIRONMENT_SLUG" | tee "/tmp/eb_deploy_output.txt"
else
    echo "Creating new environment"
    eb create "$CI_ENVIRONMENT_SLUG" \
        -c "git-shoutout-$CI_ENVIRONMENT_SLUG" \
        -k $SSH_KEY \
        -s --envvars RAILS_MASTER_KEY=$RAILS_MASTER_KEY \
        | tee "/tmp/eb_deploy_output.txt"
fi

# EB CLI return status 0 even for error
if grep -c -q -i error: "/tmp/eb_deploy_output.txt"
then    
    echo 'Error found in deploy log.'
    exit 1
fi
