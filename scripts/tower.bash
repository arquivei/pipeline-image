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

if [[ -z ${SPECIFIC_SERVICE_TAG} ]]; then
  echo "SPECIFIC_SERVICE_TAG not set, using NEW template format WITHOUT specific tag"
  awx --conf.host https://${hostval} --conf.username ${userval} --conf.password ${passwordval} \
  -f human workflow_job_templates launch ${TEMPLATE_ID} \
  --extra_vars='{"deploy_version": "'"${VERSION}"'", "deploy_name": "'"${SERVICE_NAME}"'", "commit_message": "'"${COMMIT_MESSAGE}"'"}'
else
  awx --conf.host https://${hostval} --conf.username ${userval} --conf.password ${passwordval} \
  -f human workflow_job_templates launch ${TEMPLATE_ID} \
  --extra_vars='{"deploy_version": "'"${VERSION}"'", "deploy_name": "'"${SERVICE_NAME}"'", "commit_message": "'"${COMMIT_MESSAGE}"'", "specific_service_tag": "'"${SPECIFIC_SERVICE_TAG}"'"}'
fi
