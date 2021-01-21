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

#Default option
TOWER_OPTION=${TOWER_OPTION:-"kubernetes_deploy"}

if [[ $userval == "username: " ]] || [[ $passwordval == "password: " ]]
then
  echo "WARNING: Configuration has not been fully set";
  echo "   You will want to run the $ tower-cli config ";
  echo "   command for host, username, and password ";
fi

function k8s_deploy(){
  echo "current configuration settings:"
  echo $hostval
  echo $userval
  echo $VERSION

  if [[ -z ${SPECIFIC_SERVICE_TAG} ]]; then
    awx --conf.host https://${hostval} --conf.username ${userval} --conf.password ${passwordval} \
    -f human workflow_job_templates launch ${TEMPLATE_ID} \
    --extra_vars='{"deploy_version": "'"${VERSION}"'", "deploy_name": "'"${SERVICE_NAME}"'", "commit_message": "'"${COMMIT_MESSAGE}"'"}'
  else
    awx --conf.host https://${hostval} --conf.username ${userval} --conf.password ${passwordval} \
    -f human workflow_job_templates launch ${TEMPLATE_ID} \
    --extra_vars='{"deploy_version": "'"${VERSION}"'", "deploy_name": "'"${SERVICE_NAME}"'", "commit_message": "'"${COMMIT_MESSAGE}"'", "specific_service_tag": "'"${SPECIFIC_SERVICE_TAG}"'"}'
  fi
}

function dataflow_deploy(){
  echo "current configuration settings:"
  echo $hostval
  echo $userval
  echo
  echo "GCP_PROJECT: $GCP_PROJECT"
  echo "PROJECT_NAME: $PROJECT_NAME"
  echo "PROJECT_SIMPLE_VERSION: $PROJECT_SIMPLE_VERSION"
  echo "PROJECT_VERSION: $PROJECT_VERSION"
  echo "RUNNING_ENV: $RUNNING_ENV"
  echo "SRCPROJECT: $SRCPROJECT"

  awx --conf.host https://${hostval} --conf.username ${userval} --conf.password ${passwordval} \
    -f human workflow_job_templates launch ${TEMPLATE_ID} \
    --extra_vars='{"gcp_project": "'"${GCP_PROJECT}"'", "project_name": "'"${PROJECT_NAME}"'",  "project_simple_version": "'"${PROJECT_SIMPLE_VERSION}"'",  "project_version": "'"${PROJECT_VERSION}"'",  "running_env": "'"${RUNNING_ENV}"'",  "srcproject": "'"${SRCPROJECT}"'"}'
}


case $TOWER_OPTION in
  
  kubernetes_deploy)
    k8s_deploy
    ;;

  dataflow_pipeline_deploy)
    dataflow_deploy
    ;;

  *)
    echo "Option not valid, exiting"
    ;;
esac


