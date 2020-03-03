#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

export CREATED_TIME=$(date '+%a-%b-%d-%Y-%H-%M-%S')
export LOCAL_BRANCH_NAME="changes-${CREATED_TIME,,}"

echo "creating branch $LOCAL_BRANCH_NAME"

# lets setup git
jx step git credentials

git config --global --add user.name JenkinsXBot
git config --global --add user.email jenkins-x@googlegroups.com



git clone https://github.com/jenkins-x/jx-docs.git

MESSAGE="chore: updated enhancements content"

pushd jx-docs/content/en/docs/labs/enhancements
  git checkout master
  git pull
popd

pushd jx-docs
  git add *
  git commit --allow-empty -a -m "$MESSAGE"

  git push origin master
popd
