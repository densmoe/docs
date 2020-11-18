#!/bin/bash

set -ev

if ([ "${TRAVIS_PULL_REQUEST}" == "true" -a "${TRAVIS_BRANCH}" != "MvMAWSTESTDONOTMERGE" ])
then
  echo 'Pull request, not testing deploying'
  exit 0
fi

if ([ "${TRAVIS_PULL_REQUEST}" == "true" -a "${TRAVIS_BRANCH}" == "MvMAWSTESTDONOTMERGE" ])
then
  echo 'Testing AWS deployment'
  echo '$AWS_DEFAULT_REGION'
  pwd
  exit 0
fi

if ([ "${TRAVIS_BRANCH}" == "development" ])
then
  echo 'Would do development deployment'
  echo 'cf push -f ./manifest_accp.yml'
  exit 0
fi

if ([ "${TRAVIS_BRANCH}" == "master" ])
then
  echo 'Would do production deployment'
  echo 'cf zero-downtime-push $CF_APP -f ./manifest_prod.yml'
  exit 0
fi

echo 'Not deployed'
exit 0
