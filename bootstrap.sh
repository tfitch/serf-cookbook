#!/usr/bin/env bash

# this script will be executed as root
# so using ~ would be /root not /home/vagrant

# trick learned to have this run only once unless the VM is destroyed
# source: https://github.com/mitchellh/vagrant/issues/1311
test -f /etc/bootstrapped && exit

# supports Linux only
if command -v yum &>/dev/null; then
  # with multiple network adapters installed, we need to bounce network might be a vagrant config bug? Probably a virtualbox one
  /etc/init.d/network restart
  yum install -y curl
elif command -v apt-get &>/dev/null; then
  # Ubuntu commands to install curl
  apt-get update
  apt-get install -y curl unzip
else
  echo "Not on supported platform?  Neither yum or apt-get found." >&2
  exit 1
fi

# now with curl installed, get the latest chef client for the VM
curl -L https://www.opscode.com/chef/install.sh | sudo bash

# log the date in to the bootstrapped file to track that is script has been run one time
date > /etc/bootstrapped