#!/bin/bash

RELEASE_VERSION=v1.0.1
DEPLOY_SERVICE_VERSION=fdd68c0
DEPLOY_BOARD_VERSION=fdd68c0
DEPLOY_SENTINEL_VERSION=fdd68c0
AGENT_VERSION=1.2.3

my_pwd=$PWD

cd ~
rm -fr ~/teletraan-demo
rm -fr /tmp/teletraan
rm -fr /tmp/deployd
rm -fr /tmp/deploy-board

cd ~
mkdir -p teletraan-demo

cd ~/teletraan-demo
virtualenv ./venv

cd ~/teletraan-demo
mkdir -p deploy-agent
curl -L https://github.com/pinterest/teletraan/releases/download/${RELEASE_VERSION}/deploy-agent-${AGENT_VERSION}.zip > ./deploy-agent/deploy-agent-${AGENT_VERSION}.zip
echo "Deploy agent downloaded"

source ./venv/bin/activate
CURRENT_PATH=${PWD}
pip install deploy-agent==${AGENT_VERSION} --find-links=file://${CURRENT_PATH}/deploy-agent/deploy-agent-${AGENT_VERSION}.zip

cp $my_pwd/agent.conf ~/teletraan-demo/deploy-agent/agent.conf

mkdir -p /tmp/deployd
cp $my_pwd/host_info /tmp/deployd/host_info

# make sure to install dependencies before in PRE_DOWNLOAD in the master
