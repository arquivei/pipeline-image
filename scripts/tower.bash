#!/bin/bash -ex

# host = Tower host
# username = Tower username
# password = Tower user password
# VERSION = Release version

echo "Configuring Tower Settings"
hostval=${AWX_HOST:-"awx.arquivei.com.br"}
userval=${AWX_USER:-"username"}
passwordval=${AWX_PASS:-"password"}
alias awx-cli="awx --conf.host https://${hostval} --conf.username ${userval} --conf.password ${passwordval}"

if [[ $userval == "username: " ]] || [[ $passwordval == "password: " ]]
then
  echo "WARNING: Configuration has not been fully set";
  echo "   You will want to run the $ tower-cli config ";
  echo "   command for host, username, and password ";
fi

echo "current configuration settings:"
echo $hostval
echo $userval
echo $VERSION

# Let's run a tower-cli job
awx --conf.host https://${hostval} --conf.username ${userval} --conf.password ${passwordval} \
-f human workflow_job_templates launch ${TEMPLATE_ID} \
--extra_vars='{"deploy_version": "'"${VERSION}"'", "commit_message": "'"${COMMIT_MESSAGE}"'"}'
