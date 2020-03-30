FROM google/cloud-sdk:278.0.0-alpine

ENV COMMIT_MESSAGE=${COMMIT_MESSAGE:-"bnVsbA=="}
ENV VERSION=${VERSION:-"9999"}
ENV AWX_VERSION=${AWX_VERSION:-"9.2.0"}
ENV AWX_HOST=${AWX_HOST}
ENV AWX_USER=${AWX_USER}
ENV AWX_PASS=${AWX_PASS}
ENV TEMPLATE_ID=${TEMPLATE_ID}

RUN apk add --update py3-pip python3 && \
  pip3 install "https://github.com/ansible/awx/archive/${AWX_VERSION}.tar.gz#egg=awxkit&subdirectory=awxkit"

COPY ./scripts/* /usr/bin/
