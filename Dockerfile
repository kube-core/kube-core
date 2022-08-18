FROM node:16-alpine
WORKDIR /app/kube-core

RUN apk update && apk add --no-cache --update \
                    bash \
                    jq \
                    git \
                    openssh \
                    openssl \
                    curl \
                    rsync

RUN wget -O /usr/local/bin/yq "https://github.com/mikefarah/yq/releases/download/v4.25.1/yq_linux_amd64" && \
    chmod a+x /usr/local/bin/yq

RUN npm install -g yalc

ENV PYTHONUNBUFFERED=1

RUN apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi

RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin

RUN curl -sLS https://dl.get-arkade.dev | sh
RUN arkade get kubectl
RUN mv /root/.arkade/bin/kubectl /usr/local/bin/

RUN wget -q https://github.com/devops-works/binenv/releases/latest/download/binenv_linux_amd64 -O binenv
RUN chmod +x binenv && \
    mv binenv /usr/local/bin && \
    binenv update && \
    binenv install binenv 0.19.3

RUN binenv install trivy 0.30.4 && \
    mv /root/.binenv/binaries/trivy/0.30.4 /usr/local/bin/trivy && \
    chmod a+x /usr/local/bin/trivy

# GitOps dependencies
RUN apk add file

RUN pip install PyYaml 

RUN binenv install helm 3.8.0 && \
mv ~/.binenv/helm /usr/local/bin/

# RUN binenv install helmfile 0.145.2 && \
# mv ~/.binenv/helmfile /usr/local/bin/

RUN wget -q https://github.com/roboll/helmfile/releases/download/v0.144.0/helmfile_linux_386 -O helmfile
RUN chmod +x helmfile && mv helmfile /usr/local/bin

RUN binenv install kubeseal 0.18.1 && \
mv ~/.binenv/kubeseal /usr/local/bin/

RUN binenv install kustomize 4.5.5 && \
mv ~/.binenv/kustomize /usr/local/bin/

# Test dependencies
RUN pip install yamllint

RUN wget https://github.com/instrumenta/kubeval/releases/download/v0.16.1/kubeval-linux-amd64.tar.gz && \
tar xf kubeval-linux-amd64.tar.gz && \
mv kubeval /usr/local/bin

RUN wget https://github.com/Shopify/kubeaudit/releases/download/v0.14.2/kubeaudit_0.14.2_linux_amd64.tar.gz && \
tar xf kubeaudit_0.14.2_linux_amd64.tar.gz && \
mv kubeaudit /usr/local/bin

RUN wget https://github.com/zegl/kube-score/releases/download/v1.11.0/kube-score_1.11.0_linux_amd64.tar.gz && \
tar xf kube-score_1.11.0_linux_amd64.tar.gz && \
mv kube-score /usr/local/bin

RUN wget https://github.com/open-policy-agent/conftest/releases/download/v0.25.0/conftest_0.25.0_Linux_x86_64.tar.gz && \
tar xzf conftest_0.25.0_Linux_x86_64.tar.gz && \
mv conftest /usr/local/bin

RUN curl -sL https://get.garden.io/install.sh | bash -s 0.12.25
RUN cp -r /root/.garden/bin/* /usr/local/bin

# Other dependencies
RUN npm install -g semver semver-compare-cli plop

# Carvel
RUN curl -L https://carvel.dev/install.sh | sed 's/.*shasum.*//' | bash

# kube-core
RUN pip install argparse

RUN mkdir -p /app/kube-core/cli
COPY ./cli/package.json ./cli/yarn.lock /app/kube-core/cli/

RUN cd /app/kube-core/cli && yarn

COPY . /app/kube-core

RUN cd /app/kube-core/cli && npm link

RUN apk add util-linux

ENV KUBECONFIG /kube/config
ENV CLOUDSDK_CONFIG /gcloud

RUN arkade get krew
RUN mv /root/.arkade/bin/krew /usr/local/bin/
RUN krew install krew
ENv PATH="${KREW_ROOT:-/root/.krew}/bin:$PATH" 
RUN kubectl krew install slice

RUN helm plugin install https://github.com/databus23/helm-diff

# Run the container:
# docker run -v "~/.kube:/kube -v "~/.ssh":/ssh -v "~/.config/gcloud":/gcloud -v "/projects/kubernetes/repository":/app/dev -v "/kube-core/scripts":/app/kube-core/scripts -it --rm --name kube-core-dev kube-core bash
# Then inside container: 
# mkdir ~/.ssh && cp -rf /ssh/* ~/.ssh && chmod 600 ~/.ssh/id_rsa && cd /app/dev/cluster && helmfile repos && kube-core build:all
# TODO: Rework layers, optimize, share base image with devops-tools